# -*- coding: utf-8 -*-
class JavascriptStep < ActiveRecord::Base
  attr_accessible :course_ware, :title, :desc, :content, :hint, :init_code, :rule, :code_reset

  belongs_to :course_ware

  default_scope order('id asc')

  scope :by_course_ware, lambda{|course_ware| {:conditions => ['course_ware_id = ?', course_ware.id]} }
  
  after_create  :set_course_ware_total_count
  after_destroy :set_course_ware_total_count
  def set_course_ware_total_count
    count = course_ware.javascript_steps.count
    course_ware.update_attributes(:total_count => count)
  end

  before_validation :set_init_code_before_validation
  def set_init_code_before_validation
    self.init_code = '' if self.code_reset == false
  end

  def prev
    self.class.by_course_ware(course_ware).where('id < ?', self.id).last
  end

  def next
    self.class.by_course_ware(course_ware).where('id > ?', self.id).first
  end

  def create_question(user, question_attr_hash, include_code)
    question = Question.new(question_attr_hash)
    question.creator = user
    question.step = self
    question.step_history = step_histories.by_user(user).last if include_code

    question.save
    question
  end


  include StepHistory::StepMethods
end