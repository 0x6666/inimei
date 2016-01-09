# This migration comes from monologue (originally 20120120193907)
class CreateMonologuePosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.boolean :published
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :url
      t.datetime :published_at
      
      t.timestamps
    end

    add_index :blog_posts, :published_at
    add_index :blog_posts, :url, unique: true
  end
end
