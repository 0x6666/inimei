class CreateBlogSettings < ActiveRecord::Migration
  def change
    create_table :blog_settings do |t|
      t.references :user, index: true
      t.string :blog_name
      t.string :blog_subtitle
      t.integer :blogs_per_page
      t.integer :blog_preview_size
      t.string :linkedin_url
      t.string :weibo_name
      t.string :domain

      t.timestamps null: false
    end
    add_foreign_key :blog_settings, :users
    add_index :blog_settings, :domain, unique: true
  end
end
