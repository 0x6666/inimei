class CreateSubSchedules < ActiveRecord::Migration
  def change
    create_table :sub_schedules do |t|
      t.text :content
      t.references :schedule, index: true

      t.timestamps null: false
    end
    add_foreign_key :sub_schedules, :schedules
  end
end
