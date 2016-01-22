module Blog
  class Configuration

    attr_accessor :disqus_shortname,
                  :site_url,
                  :meta_description,
                  :meta_keyword,

                  :show_rss_icon,

                  :github_username,

                  :admin_force_ssl,
                  :layout,
                  :sidebar

    def initialize
      @site_url = 'https://www.inimei.net'

      @meta_description = "I don't know!!"
      @meta_keyword = 'Music, Reading'

      @admin_force_ssl = true

      @disqus_shortname = 'my_disqus_shortname'
      @sidebar = %w[categories latest_posts] # tag_cloud 'latest_tweets',
    end
  end

  Config = Configuration.new

  def self.table_name_prefix
    'blog_'
  end
end