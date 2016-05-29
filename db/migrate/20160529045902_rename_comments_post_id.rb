class RenameCommentsPostId < ActiveRecord::Migration
  def change
    rename_column :blog_comments, :blog_post_id, :post_id
  end
end
