require 'spec_helper'
if R::SELECT_COURSE_MODE == 'THREE'
describe SelectCourseIntent do
  before{
    @course_1 = FactoryGirl.create :course, :approve_status => Course::APPROVE_STATUS_YES
    @course_2 = FactoryGirl.create :course, :approve_status => Course::APPROVE_STATUS_YES
    @course_3 = FactoryGirl.create :course, :approve_status => Course::APPROVE_STATUS_YES
    @course_4 = FactoryGirl.create :course, :approve_status => Course::APPROVE_STATUS_YES

    @group_tree_node_1 = FactoryGirl.create :group_tree_node
    @group_tree_node_2 = FactoryGirl.create :group_tree_node

    @user_1 = FactoryGirl.create :user
    @user_2 = FactoryGirl.create :user
    @user_3 = FactoryGirl.create :user
    @user_4 = FactoryGirl.create :user
    @user_5 = FactoryGirl.create :user
    @user_6 = FactoryGirl.create :user
    @user_7 = FactoryGirl.create :user
    @user_8 = FactoryGirl.create :user
    @user_9 = FactoryGirl.create :user
    @user_10 = FactoryGirl.create :user
    @user_11 = FactoryGirl.create :user
    @user_12 = FactoryGirl.create :user

    @group_tree_node_1.add_user(@user_1)
    @group_tree_node_1.add_user(@user_2)
    @group_tree_node_1.add_user(@user_3)
    @group_tree_node_1.add_user(@user_4)
    @group_tree_node_1.add_user(@user_5)
    @group_tree_node_1.add_user(@user_6)

    @group_tree_node_2.add_user(@user_7)
    @group_tree_node_2.add_user(@user_8)
    @group_tree_node_2.add_user(@user_9)
    @group_tree_node_2.add_user(@user_10)
    @group_tree_node_2.add_user(@user_11)
    @group_tree_node_2.add_user(@user_12)
  }

  context '12 个学生 分别填写志愿' do
    before{
      ## group_tree_node_1
      # user_1
      @user_1.set_select_course_intent :first, @course_1
      @user_1.set_select_course_intent :second, @course_2
      @user_1.set_select_course_intent :third, @course_3
      # user_2
      @user_2.set_select_course_intent :first, @course_1
      @user_2.set_select_course_intent :second, @course_2
      @user_2.set_select_course_intent :third, @course_3
      # user_3
      @user_3.set_select_course_intent :first, @course_1
      @user_3.set_select_course_intent :second, @course_2
      @user_3.set_select_course_intent :third, @course_3
      # user_4
      @user_4.set_select_course_intent :first, @course_2
      @user_4.set_select_course_intent :second, @course_3
      @user_4.set_select_course_intent :third, @course_4
      # user_5
      @user_5.set_select_course_intent :first, @course_2
      @user_5.set_select_course_intent :second, @course_3
      @user_5.set_select_course_intent :third, @course_4
      # user_6
      @user_6.set_select_course_intent :first, @course_3
      @user_6.set_select_course_intent :second, @course_4
      @user_6.set_select_course_intent :third, @course_1
      #####
      ## group_tree_node_2
      # user_7
      @user_7.set_select_course_intent :first, @course_1
      @user_7.set_select_course_intent :second, @course_2
      @user_7.set_select_course_intent :third, @course_3
      # user_8
      @user_8.set_select_course_intent :first, @course_1
      @user_8.set_select_course_intent :second, @course_2
      @user_8.set_select_course_intent :third, @course_3
      # user_9
      @user_9.set_select_course_intent :first, @course_1
      @user_9.set_select_course_intent :second, @course_2
      @user_9.set_select_course_intent :third, @course_3
      # user_10
      @user_10.set_select_course_intent :first, @course_2
      @user_10.set_select_course_intent :second, @course_3
      @user_10.set_select_course_intent :third, @course_4
      # user_11
      @user_11.set_select_course_intent :first, @course_2
      @user_11.set_select_course_intent :second, @course_3
      @user_11.set_select_course_intent :third, @course_4
      # user_12
      @user_12.set_select_course_intent :first, @course_3
      @user_12.set_select_course_intent :second, @course_4
      @user_12.set_select_course_intent :third, @course_1
    }

    it{
      @course_1.intent_users_count(:flag => :first).should == 6
      @course_1.intent_users_count(:flag => :second).should == 0
      @course_1.intent_users_count(:flag => :third).should == 2
      @course_1.intent_users_count.should == 8
    }

    it{
      @course_1.intent_users_count(:flag => :first, :group_tree_node => @group_tree_node_1).should == 3
      @course_1.intent_users_count(:flag => :second, :group_tree_node => @group_tree_node_1).should == 0
      @course_1.intent_users_count(:flag => :third, :group_tree_node => @group_tree_node_1).should == 1
      @course_1.intent_users_count(:group_tree_node => @group_tree_node_1).should == 4
    }

    it{
      CourseIntent.intent_course_ranking(:flag => :first).map {|c|
        [c, c.intent_users_count(:flag => :first)]
      }.should == [
        [@course_1, 6],
        [@course_2, 4],
        [@course_3, 2]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:flag => :second).map {|c|
        [c, c.intent_users_count(:flag => :second)]
      }.should == [
        [@course_2, 6],
        [@course_3, 4],
        [@course_4, 2]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:flag => :third).map {|c|
        [c, c.intent_users_count(:flag => :third)]
      }.should == [
        [@course_3, 6],
        [@course_4, 4],
        [@course_1, 2]
      ]
    }

    it{
      CourseIntent.intent_course_ranking.map {|c|
        [c, c.intent_users_count]
      }.should == [
        [@course_3, 12],
        [@course_2, 10],
        [@course_1, 8],
        [@course_4, 6]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:group_tree_node => @group_tree_node_1, :flag => :first).map {|c|
        [c, c.intent_users_count(:group_tree_node => @group_tree_node_1, :flag => :first)]
      }.should == [
        [@course_1, 3],
        [@course_2, 2],
        [@course_3, 1]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:group_tree_node => @group_tree_node_1, :flag => :second).map {|c|
        [c, c.intent_users_count(:group_tree_node => @group_tree_node_1, :flag => :second)]
      }.should == [
        [@course_2, 3],
        [@course_3, 2],
        [@course_4, 1]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:group_tree_node => @group_tree_node_1, :flag => :third).map {|c|
        [c, c.intent_users_count(:group_tree_node => @group_tree_node_1, :flag => :third)]
      }.should == [
        [@course_3, 3],
        [@course_4, 2],
        [@course_1, 1]
      ]
    }

    it{
      CourseIntent.intent_course_ranking(:group_tree_node => @group_tree_node_1).map {|c|
        [c, c.intent_users_count(:group_tree_node => @group_tree_node_1)]
      }.should == [
        [@course_3, 6],
        [@course_2, 5],
        [@course_1, 4],
        [@course_4, 3]
      ]
    }

    ## users
    it{
      @course_1.intent_users(:flag => :first).should =~ [
        @user_1, @user_2, @user_3, @user_7, @user_9, @user_8
      ]
    }

    it{
      @course_1.intent_users(:flag => :second).should =~ []
    }

    it{
      @course_1.intent_users(:flag => :third).should =~ [
        @user_6, @user_12
      ]
    }

    it{
      @course_1.intent_users.should =~ [
         @user_1, @user_2, @user_3, @user_6,
         @user_7, @user_9, @user_8, @user_12
      ]
    }

    it{
      @course_1.intent_users(:flag => :first, :group_tree_node => @group_tree_node_1).should =~ [
        @user_1, @user_2, @user_3
      ]
    }

    it{
      @course_1.intent_users(:flag => :second, :group_tree_node => @group_tree_node_1).should =~ []
    }

    it{
      @course_1.intent_users(:flag => :third, :group_tree_node => @group_tree_node_1).should =~ [
        @user_6
      ]
    }

    it{
      @course_1.intent_users(:group_tree_node => @group_tree_node_1).should =~ [
         @user_1, @user_2, @user_3, @user_6
      ]
    }
  end
end
end