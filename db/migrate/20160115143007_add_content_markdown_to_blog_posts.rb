class AddContentMarkdownToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :content_markdown, :boolean, default: true
  end
end
