jQuery ->
  search = ($input)->
    q = jQuery.trim $input.val()
    if q != ''
      location.href = "/search/#{q}"

  $input = jQuery('.page-search-bar input[name=q]')
  $input.keydown (evt)=>
    if evt.keyCode == 13
      search($input)

  jQuery('.page-search-bar .do-search').on 'click', ->
    search($input)

# 20140325 top bar search
jQuery ->
  search = ($input)->
    q = jQuery.trim $input.val()
    if q.length > 0
      location.href = "/search/#{q}"

  $input = jQuery('.page-top-nav input.top-search')
  $input.keydown (evt)=>
    if evt.keyCode == 13
      search($input)

# 20140429 课程中心
jQuery ->
  search = ($input)->
    q = jQuery.trim $input.val()
    if q.length > 0
      location.href = "/search/#{q}"

  $input = jQuery('.page-course-center-search input.course-search')
  
  $input.keydown (evt)->
    if evt.keyCode == 13
      search $input

  jQuery('.page-course-center-search a.do-search').click ->
    search $input

# ----------

jQuery ->
  search = ($input)->
    q = jQuery.trim $input.val()
    location.href = "/admin/users?q=#{q}"

  $input = jQuery('.page-filter.admin-users input[name=q]')
  $input.keydown (evt)=>
    if evt.keyCode == 13
      search($input)

  jQuery('.page-filter.admin-users .do-search').on 'click', ->
    search($input)

jQuery ->
  search = ($input)->
    q = jQuery.trim $input.val()
    location.href = "/manage/courses?q=#{q}"

  $input = jQuery('.page-filter.manage-courses input[name=q]')
  $input.keydown (evt)=>
    if evt.keyCode == 13
      search($input)

  jQuery('.page-filter.manage-courses .do-search').on 'click', ->
    search($input)