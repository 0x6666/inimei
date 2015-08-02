class UserMailer < ApplicationMailer
  default from: 'yangsongfwd@163.com'

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account Activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end
end
