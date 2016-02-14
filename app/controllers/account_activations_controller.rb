class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by_email params[:email]
    if user && !user.auth_info.activated? && user.auth_info.authenticated?(:activation, params[:id])
      user.auth_info.activate

      log_in user
      flash[:success] = 'Account activated!'
      redirect_to user_path(user)
    else
      flash[:danger] = 'Invalid activation link!'
      redirect_to root_url
    end
  end
end
