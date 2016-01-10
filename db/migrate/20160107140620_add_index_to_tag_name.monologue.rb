class AddIndexToTagName < ActiveRecord::Migration
  def change
    add_index :blog_tags, :name
  end
end
