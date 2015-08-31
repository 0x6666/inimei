class AddCompletedToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :completed, :boolean, default: false
  end
end
