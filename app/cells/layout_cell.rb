class LayoutCell < Cell::Rails
  helper :application

  def google_analytics_code
    render
  end

  def topnav(opts = {})
    @user = opts[:user]
    @for = opts[:for]
    render
  end

  def topnav_admin(opts = {})
    @user = opts[:user]
    render
  end

  def topnav_coding(opts = {})
    @user = opts[:user]
    @preview = opts[:preview]
    @course_ware = opts[:course_ware]
    render
  end

  def searchbar(opts = {})
    @user = opts[:user]
    render
  end

  def sidebar(opts = {})
    @user = opts[:user]
    @for = opts[:for]
    render
  end

  def account_sidebar(opts = {})
    @user = opts[:user]
    render
  end

  def help_sidebar(opts = {})
    @user = opts[:user]
    render
  end

  def admin_users_filter(opts = {})
    @query = opts[:query]
    render
  end

  def manage_courses_filter(opts = {})
    @query = opts[:query]
    render
  end

  def medals_coding(opts = {})
    @user = opts[:user]
    render
  end

  def file_uploader(opts = {})
    @name = opts[:name] || 'file_entity_id'
    @multi = opts[:multi] || false
    @uploaded_file_name = opts[:uploaded_file_name]
    render
  end
end