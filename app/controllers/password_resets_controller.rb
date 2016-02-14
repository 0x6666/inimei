class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:danger] = "Password/confirmation can't be blank"
      render 'edit'
    elsif @user.auth_info.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Password has been reset.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.find_by_email params[:password_reset][:email].downcase
    if @user
      @user.auth_info.create_reset_digest
      @user.auth_info.send_password_reset_emil
      flash[:info]='Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  private
  def get_user
    @user = User.find_by_email params[:email]
  end

  def valid_user
    unless (@user && @user.auth_info.activated? && @user.auth_info.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def both_passwords_blank?
    params[:user][:password].blank? &&
        params[:user][:password_confirmation].blank?
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def check_expiration
    if @user.auth_info.password_reset_expired?
      flash[:danger] = 'Password reset has expired.'
      redirect_to new_password_reset_url
    end
  end
end
