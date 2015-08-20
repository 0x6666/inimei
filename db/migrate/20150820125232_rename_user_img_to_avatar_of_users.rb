class RenameUserImgToAvatarOfUsers < ActiveRecord::Migration
  def change
    rename_column :users, :user_img, :avatar
  end
end
