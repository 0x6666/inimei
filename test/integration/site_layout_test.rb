require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'layout links' do
    get root_path
    assert_redirected_to about_path

=begin
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', 'mailto:yangsongfwd@163.com' #contact_path
    assert_select 'a[href=?]', users_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', login_path
=end

    log_in_as @user
    get root_path
    assert_select 'a[href=?]', schedules_user_path(@user)
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a[href=?]', logout_path

    delete logout_path
    log_in_as users(:archer)
    get root_path
    assert_select 'a[href=?]', users_path, count: 0
  end

end
