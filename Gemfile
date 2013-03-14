source 'http://ruby.taobao.org'

gem 'rails', '3.2.12' # RAILS
gem 'mysql2', '0.3.11' # MYSQL数据库连接
gem 'json', '1.7.7' # JSON解析，RAILS默认引入的

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3', '0.3.2' # 加速预编译
end

group :test do
  gem 'rspec-rails', '2.13.0'
  gem 'database_cleaner', '0.9.1' # 加速测试时数据库清理
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'coveralls', :require => false # 帮助在 coveralls.io 线统计测试覆盖率
  gem 'capybara', '2.0.2' # 集成测试框架
end

group :examples do
  gem 'ruby-progressbar', '~> 1.0.2'
end

gem 'jquery-rails', '2.2.1'
gem 'unicorn', '4.6.2'

# 登录验证
gem 'devise', '2.2.3'

# 页面渲染
gem 'haml', '4.0.0' # HAML模板语言
gem 'cells', '3.8.8' # 用于复用一些前端组件
gem 'simple_form', '2.0.2' # 用于简化表单创建

# 数据查询
gem 'pacecar', '1.5.3' # 给模型添加实用的scope
gem 'kaminari', '0.14.1' # 分页支持

# 文件上传（fushang318增加） 
gem "carrierwave", "0.8.0"
# carrierwave 用到的图片切割
gem "mini_magick", "3.5.0", :require => false

# 解析 excel 文件
gem 'roo', '1.10.3'

# 编码处理基础库
gem 'iconv', '1.0.2'

# 自己写的 gem，都不指定版本号，如果有重大修改，通过GIT TAG解决

## 用户角色
gem 'roles-field',
    :git => 'git://github.com/mindpin/roles-field.git'
    # :path => '/web/songliang/roles-field'

## 导航栏
gem 'simple-navbar',
    :git => 'git://github.com/mindpin/simple-navbar.git'

## 页面布局辅助
gem 'simple-page-layout',
    :git => 'git://github.com/mindpin/simple-page-layout'

## 在页面上显示图片的一些辅助方法
gem 'simple-images',
    :git => 'git://github.com/mindpin/simple-images'

gem 'simple-page-compoents',
    :git => 'git://github.com/mindpin/simple-page-compoents'
    # :path => '/web/songliang/simple-page-compoents'

## 给指定 activerecord 模型动态添加属性
gem 'dynamic_attrs',
    :git => 'git://github.com/kaid/dynamic_attrs.git'
