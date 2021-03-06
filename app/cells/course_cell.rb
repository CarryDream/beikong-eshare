class CourseCell < Cell::Rails
  helper :application

  # ---- cards

  def card(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def smallcard(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def recent_learning(opts = {})
    @user = opts[:user]
    @courses = @user.learning_courses.limit(5)
    render
  end

  def advise(opts = {})
    @user = opts[:user]
    @courses = @user.advise_courses
    render
  end

  def checkin(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def student_select(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def sidebar(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def header(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def baseinfo(opts = {})
    @course = opts[:course]
    render
  end

  def chapter_baseinfo(opts = {})
    @chapter = opts[:chapter]
    render
  end

  def show_chapters(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def learning_users(opts = {})
    @course = opts[:course]
    render
  end

  def learning_chart(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def navbar(opts = {})
    @course = opts[:course]
    render
  end

  def index_navbar
    render
  end

  def user_attitudes_form(opts = {})
    @course = opts[:course]
    @user = opts[:user]
    render
  end

  def sch_select_table(opts = {})
    @courses = opts[:courses]
    @user = opts[:user]
    render
  end

  def chapter_table_ajax_form(opts = {})
    @chapter = opts[:chapter]
    render
  end

  def course_ware_table_ajax_form(opts = {})
    @course_ware = opts[:course_ware]
    render
  end
end