class CourseWareReading < ActiveRecord::Base
  attr_accessible :user, :read, :read_count

  belongs_to :user
  belongs_to :course_ware

  scope :by_user, lambda {|user| {:conditions => {:user_id => user.id}}}
  scope :by_read, lambda {|read| {:conditions => {:read => read}}}
end
