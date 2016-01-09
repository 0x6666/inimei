class Blog::Admin::BaseController < Blog::BlogBaseController
  include Blog::ControllerHelpers::Auth

  #force_ssl if Blog::Config.admin_force_ssl # TODO: find a way to test that with capybara
  
  layout 'layouts/blog/admin'
end