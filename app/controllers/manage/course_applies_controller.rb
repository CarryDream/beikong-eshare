class Manage::CourseAppliesController < ApplicationController
  # before_filter :authenticate_user!
  # layout :get_layout
  # def get_layout
  #   return 'manage'
  # end
  
  # def index
  #   @course = Course.find(params[:course_id])
  #   applies = @course.select_course_applies.page(params[:page])
  #   applies.each do |apply|
  #     apply.destroy if apply.course.blank?
  #   end
  #   @applies = @course.select_course_applies.page(params[:page])
  # end

  # def status_request
  #   @course = Course.find(params[:course_id])
  #   @applies = @course.select_course_applies.by_status(SelectCourseApply::STATUS_REQUEST).page(params[:page])
  #   render :action => :index
  # end

  # def status_accept
  #   @course = Course.find(params[:course_id])
  #   @applies = @course.select_course_applies.by_status(SelectCourseApply::STATUS_ACCEPT).page(params[:page])
  #   render :action => :index
  # end

  # def status_reject
  #   @course = Course.find(params[:course_id])
  #   @applies = @course.select_course_applies.by_status(SelectCourseApply::STATUS_REJECT).page(params[:page])
  #   render :action => :index
  # end
end