require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:michael)
    user.auth_info.activation_token = AuthInfo.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'Account Activation', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['yangsongfwd@163.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end

  test 'password_reset' do
    user = users(:michael)
    user.auth_info.reset_token = AuthInfo.new_token
    mail = UserMailer.password_reset(user)
    assert_equal 'Password Reset', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['yangsongfwd@163.com'], mail.from
    assert_match user.auth_info.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

end
