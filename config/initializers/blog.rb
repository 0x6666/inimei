module Blog
  class Configuration

    attr_accessor :disqus_shortname,
                  :site_name,
                  :site_subtitle,
                  :site_url,
                  :meta_description,
                  :meta_keyword,

                  :show_rss_icon,

                  :linkedin_url,

                  :github_username,

                  :admin_force_ssl,
                  :posts_per_page,
                  :admin_posts_per_page,
                  :layout,
                  :sidebar,
                  :weibo_name

    def initialize
      @site_name = 'INiMei Blog'
      @site_subtitle = 'Just enjoy every moment'
      @site_url = 'https://www.inimei.net'

      @meta_description = "I don't know!!"
      @meta_keyword = 'Music, Reading'

      @admin_force_ssl = true
      @posts_per_page = 10
      @preview_size = 1000

      @disqus_shortname = 'my_disqus_shortname'
      @sidebar = %w[categories latest_posts] # tag_cloud 'latest_tweets',

      @linkedin_url = 'https://www.linkedin.com/in/%E6%9D%BE-%E6%9D%A8-1aa96aa2'
      @weibo_name = 'borrowedstory'
    end
  end

  Config = Configuration.new

  def self.table_name_prefix
    'blog_'
  end
end