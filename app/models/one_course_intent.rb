class OneCourseIntent < ActiveRecord::Base
  attr_accessible :user, :course, :content

  belongs_to :user
  belongs_to :course

  validates :user,    :presence => true
  validates :course,  :presence => true
  validates :user_id,  :uniqueness => {:scope => :course_id}

  module ClassMethods
    def intent_course_ranking(options = {})
      group_tree_node = options[:group_tree_node]

      group_tree_node_join_sql = group_tree_node.blank? ? "" : %`
        INNER JOIN group_tree_node_users 
        ON 
          group_tree_node_users.user_id = one_course_intents.user_id
            AND
          group_tree_node_users.group_tree_node_id = #{group_tree_node.id}
      `

      ocis_join_sql = %`
        LEFT OUTER JOIN
        (
          SELECT one_course_intents.course_id, IFNULL(count(one_course_intents.user_id), 0) as count
          FROM one_course_intents
          #{group_tree_node_join_sql}
          GROUP BY one_course_intents.course_id
        ) AS ocis
        ON ocis.course_id = courses.id
      `
      Course.unscoped.approve_status_with_yes.joins(ocis_join_sql).order("ocis.count desc")
    end
  end

  module UserMethods
    def self.included(base)
      base.has_many :one_course_intents
      base.has_many :intent_courses, :through => :one_course_intents, :source => :course
    end

    def remove_course_intent(course)
      self.one_course_intents.where(:course_id => course.id).destroy_all
    end

    def add_course_intent(course, content = nil)
      return if intent_courses.include?(course)

      self.one_course_intents.create(:course => course, :content => content)
    end
  end

  module CourseMethods
    def self.included(base)
      base.has_many :one_course_intents
    end

    def intent_and_selected_users
      join_sql = %`
        LEFT JOIN select_courses
          ON select_courses.user_id = users.id
            AND
          select_courses.course_id = #{self.id}
        LEFT JOIN one_course_intents
          ON one_course_intents.user_id = users.id
            AND
          one_course_intents.course_id = #{self.id}
      `
      where_sql = %`
        one_course_intents.user_id IS NOT NULL
          OR
        select_courses.user_id IS NOT NULL
      `
      User.joins(join_sql).where(where_sql).with_role(:student)
    end

    def intent_student_users(options = {})
      intent_users(options)
    end

    def intent_student_count(options = {})
      intent_users_count(options)
    end

    def intent_users(options = {})
      group_tree_node = options[:group_tree_node]
      order_by_sql = %`
        one_course_intents.created_at ASC
      `

      oci_join_sql = %`
        INNER JOIN 
          one_course_intents 
        ON 
          one_course_intents.user_id = users.id 
            AND 
          one_course_intents.course_id = #{self.id}
      `
      return User.unscoped.joins(oci_join_sql).order(order_by_sql) if group_tree_node.blank?
      
      group_tree_node_join_sql = %`
        INNER JOIN group_tree_node_users 
        ON 
          group_tree_node_users.user_id = one_course_intents.user_id
            AND
          group_tree_node_users.group_tree_node_id = #{group_tree_node.id}
      `

      User.joins(oci_join_sql).joins(group_tree_node_join_sql).order(order_by_sql)
    end

    def intent_users_count(options = {})
      group_tree_node = options[:group_tree_node]

      if group_tree_node.blank?
        return OneCourseIntent.where(:course_id => self.id).count
      end

      group_tree_node_join_sql = %`
        INNER JOIN group_tree_node_users 
        ON 
          group_tree_node_users.user_id = one_course_intents.user_id
            AND
          group_tree_node_users.group_tree_node_id = #{group_tree_node.id}
      `

      return OneCourseIntent
        .joins(group_tree_node_join_sql)
        .where(:course_id => self.id).count
    end

    def select_status_of_user(user)
      return "选中" if self.selected_users.include?(user)
      return "未选中" if self.be_reject_selected_users.include?(user)
      return "等待志愿分配" if self.intent_users.include?(user)
      return "未申请"
    end

    def intent_status
      iucount = self.intent_users_count

      return "无人申请" if iucount == 0
      return "人数过少" if iucount < self.least_user_count
      return "人数适合" if iucount >= least_user_count && iucount <= most_user_count
      return "人数过多"
    end

    # 批量处理申请，先到先得
    def batch_check
      iusers = self.intent_users
      selected_count = self.selected_users.count
      max_count = self.most_user_count

      iusers.each do |user|
        if selected_users.include?(user) || be_reject_selected_users.include?(user)
          next
        end

        is_course_full = selected_count >= max_count

        if is_course_full
          user.select_course(:reject, self)
        else
          user.select_course(:accept, self)
          selected_count += 1
        end

      end
    end

    def need_adjust_users
      join_sql = %`
        INNER JOIN 
        (
          SELECT users.id, sum(IFNULL(courses.credit, 0)) AS S
          FROM users
          LEFT OUTER JOIN select_courses ON select_courses.user_id = users.id AND select_courses.course_id = #{self.id}
          LEFT OUTER JOIN courses ON courses.id = select_courses.course_id
          WHERE select_courses.course_id IS NULL
          GROUP BY users.id
        ) AS USER_AND_SUMS
      ON
        USER_AND_SUMS.id = users.id 
      AND 
        USER_AND_SUMS.S < #{R::LEAST_SELECT_CREDIT}

      `

      User.joins(join_sql).with_role(:student)
    end

  end
end
