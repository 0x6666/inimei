class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :content
      t.datetime :completed_at
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :schedules, :users
  end
end
