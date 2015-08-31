class RemoveIndexCreatedAtToSchedules < ActiveRecord::Migration
  def change
    remove_index :schedules, :created_at
  end
end
