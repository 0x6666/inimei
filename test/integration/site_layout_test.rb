require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'layout links' do
    get root_path
    if is_logged_in?
      assert_template 'static_pages/home'
      assert_select 'a[href=?]', root_path, count: 2
      assert_select 'a[href=?]', help_path
      assert_select 'a[href=?]', about_path
      assert_select 'a[href=?]', 'mailto:yangsongfwd@163.com' #contact_path
    else
      assert_redirected_to about_path
    end
  end

end
