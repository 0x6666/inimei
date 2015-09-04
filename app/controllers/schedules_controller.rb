class SchedulesController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create, :update, :complete, :uncomplete]
  before_action :correct_user, only: [:destroy, :update, :complete, :uncomplete]

  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Schedule deleted!'
        redirect_to request.referrer || root_url
      end
      format.js
    end
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)

    if @schedule.save
      flash[:success]='Schedule Created!'
      date = @schedule.planed_completed_at
    else
      flash[:success]='Create Schedule failed!'
      date = Time.now
    end

    redirect_to schedules_user_path(current_user, date: {year: date.year, month: date.month, day: date.day})
  end

  def update
    @need_remove = false
    type = params[:type]
    if type == 'after-a-day'
      @need_remove = true
      now_date = @schedule.planed_completed_at || Time.now
      su = @schedule.update_attributes(planed_completed_at: now_date.days_since(1))
    elsif type == 'after-a-week'
      @need_remove = true
      now_date = @schedule.planed_completed_at || Time.now
      su = @schedule.update_attributes(planed_completed_at: now_date.weeks_since(1))
    elsif type == 'no-plan'
      date = @schedule.planed_completed_at
      su = @schedule.update_attributes(planed_completed_at: nil)
      redirect_to schedules_user_path(current_user, date: {year: date.year, month: date.month, day: date.day})
      return
    else
      su = @schedule.update_attributes(schedule_params)
      date = @schedule.planed_completed_at
      redirect_to schedules_user_path(current_user, date: {year: date.year, month: date.month, day: date.day})
      return
    end

    #if su
    #flash[:success]='Schedule updated!'
    #else
    #flash[:success]='Update Schedule Failed!'
    #end

    respond_to do |format|
      format.js
    end
  end

  def complete
    @schedule.complete
    date = @schedule.planed_completed_at
    redirect_to schedules_user_path(current_user, date: {year: date.year, month: date.month, day: date.day})
  end

  def uncomplete
    @schedule.uncomplete
    date = @schedule.planed_completed_at
    redirect_to schedules_user_path(current_user, date: {year: date.year, month: date.month, day: date.day})
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :content, :planed_completed_at)
  end

  def correct_user
    @schedule = current_user.schedules.find_by_id(params[:id])
    redirect_to root_url if @schedule.nil?
  end

end
