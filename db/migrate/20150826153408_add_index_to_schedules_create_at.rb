class AddIndexToSchedulesCreateAt < ActiveRecord::Migration
  def change
    add_index :schedules, :created_at
  end
end
