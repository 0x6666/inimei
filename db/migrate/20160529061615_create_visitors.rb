class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :ip

      t.timestamps null: false
    end

    add_index :visitors, :ip, unique: true
  end
end
