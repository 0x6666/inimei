class AddPlanedCompletedAtToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :planed_completed_at, :datetime
  end
end
