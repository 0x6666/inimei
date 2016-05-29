class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.text :content
      t.references :user, index: true
      t.references :blog_post, index: true

      t.timestamps null: false
    end
    add_foreign_key :blog_comments, :users
    add_foreign_key :blog_comments, :blog_posts

  end
end
