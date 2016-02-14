class SessionsController < ApplicationController
  #render login page
  def new
  end

  # create session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.auth_info.authenticate(params[:session][:password])
      if user.auth_info.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user_path(user)
      else
        flash[:warning] = 'Account not activated.Check your email for the activation link.'
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #log out
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
