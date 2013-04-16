class Manage::CourseWaresController < ApplicationController
  before_filter :authenticate_user!

  def index
    @chapter = Chapter.find(params[:chapter_id])
  end

  def new
    @chapter = Chapter.find(params[:chapter_id])
    @course_ware = @chapter.course_wares.new
  end

  def create
    @chapter = Chapter.find(params[:chapter_id])
    @course_ware = @chapter.course_wares.build(params[:course_ware], :as => :upload)
    @course_ware.creator = current_user
    if @course_ware.save
      return redirect_to "/manage/chapters/#{@chapter.id}"
    end
    render :action => :new
  end

  def edit
    @course_ware = CourseWare.find(params[:id])
    @chapter = @course_ware.chapter
  end

  def update
    @course_ware = CourseWare.find(params[:id])
    @chapter = @course_ware.chapter
    if @course_ware.update_attributes(params[:course_ware])
      return redirect_to "/manage/chapters/#{@chapter.id}"
    end
    render :action => :edit
  end

  def destroy
    @course_ware = CourseWare.find(params[:id])
    @chapter = @course_ware.chapter
    @course_ware.destroy
    return redirect_to "/manage/chapters/#{@chapter.id}"
  end

end