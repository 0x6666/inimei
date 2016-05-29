class AddIndexToBlogSettingsUser < ActiveRecord::Migration
  def change
    change_column :blog_settings, :user_id, :integer, unique: true
  end
end
