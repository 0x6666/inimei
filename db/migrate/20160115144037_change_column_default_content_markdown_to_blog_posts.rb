class ChangeColumnDefaultContentMarkdownToBlogPosts < ActiveRecord::Migration
  def change
    change_column_default(:blog_posts, :content_markdown, true)
  end
end
