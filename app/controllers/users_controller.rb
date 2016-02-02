class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :following, :followers, :schedules]
  before_action :correct_user, only: [:edit, :update, :schedules]
  before_action :admin_user, only: [:destroy, :index]

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User Deleted!'
    redirect_to users_url
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new' #failed
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def basic_setting
    @user = User.find(params[:id])
    if @user.update_attributes(user_basic)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def password_setting

  end

  def blog_setting

  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def schedules
    @user = current_user
    date = params[:date]
    @select_date = date.nil? ? Time.now : Time.new(date[:year], date[:month], date[:day]).end_of_day
    @current_schedules = @user.schedules.where(completed: false, planed_completed_at: @select_date.all_day)
    @current_competed_schedules = @user.schedules.where(completed: true, planed_completed_at: @select_date.all_day)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def user_basic
    p = params.require(:user).permit(:name, :email, :avatar)
    p
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
