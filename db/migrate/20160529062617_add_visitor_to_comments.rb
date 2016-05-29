class AddVisitorToComments < ActiveRecord::Migration
  def change
    add_column :blog_comments, :visitor_id, :integer, default: 0
    add_index :blog_comments, :visitor_id
  end
end
