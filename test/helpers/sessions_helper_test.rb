require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert is_logged_in?
  end
  test 'current_user returns nil when remember digest is wrong' do
    auth_info = @user.auth_info
    auth_info.update_attribute(:remember_digest, AuthInfo.digest(AuthInfo.new_token))
    assert_nil current_user
  end
end