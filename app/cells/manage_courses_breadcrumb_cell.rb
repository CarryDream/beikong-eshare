class ManageCoursesBreadcrumbCell < Cell::Rails
  def display(opts = {})
    @model = opts[:model]
    render
  end

  def design(opts = {})
    @model = opts[:model]
    render
  end

  def form(opts = {})
    @model = opts[:model]
    render
  end

  def design_form(opts = {})
    @model = opts[:model]
    render
  end

  def applies(opts = {})
    @course = opts[:course]
    render
  end
end