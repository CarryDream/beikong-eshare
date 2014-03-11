class Practice < ActiveRecord::Base
  include PracticeRecord::PracticeMethods
  include Attachment::ModelMethods

  attr_accessible :title, :content, :chapter, :creator

  belongs_to :creator, :class_name => 'User', :foreign_key => :creator_id
  belongs_to :chapter

  has_many :uploads, :class_name => 'PracticeUpload', :foreign_key => :practice_id

  validates :title, :chapter, :creator, :presence => true

  scope :by_creator, lambda{|creator| where(:creator_id => creator.id) }
  scope :by_course, lambda{|course| joins(:chapter).where('chapters.course_id = ?', course.id) }

  module UserMethods
    def self.included(base)
      base.has_many :practices, :class_name => 'Practice', :foreign_key => :creator_id
    end
  end

end
