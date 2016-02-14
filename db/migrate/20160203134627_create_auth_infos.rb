class CreateAuthInfos < ActiveRecord::Migration
  def change
    create_table :auth_infos do |t|
      t.string :password_digest
      t.references :user, index: true
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps null: false
    end
    add_foreign_key :auth_infos, :users
  end
end
