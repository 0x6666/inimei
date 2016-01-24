class CreateBlogSettings < ActiveRecord::Migration
  def change
    create_table :blog_settings do |t|
      t.references :user, index: true
      t.string :blog_name,  default: 'INiMei Blog'
      t.string :blog_subtitle, default: 'No subtitle'
      t.integer :blogs_per_page, default: 10
      t.integer :blog_preview_size, default: 150
      t.string :linkedin_url
      t.string :weibo_name
      t.string :domain

      t.timestamps null: false
    end
    add_foreign_key :blog_settings, :users
    add_index :blog_settings, :domain, unique: true
  end
end
