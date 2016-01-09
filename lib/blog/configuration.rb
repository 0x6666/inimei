module Blog
  class Configuration

    attr_accessor :disqus_shortname,
                  :site_name,
                  :site_subtitle,
                  :site_url,
                  :meta_description,
                  :meta_keyword,

                  :show_rss_icon,

                  :twitter_username,
                  :twitter_locale,

                  :facebook_like_locale,
                  :facebook_url,
                  :facebook_logo, #used in the open graph protocol to display an image when a post is liked
                  :facebook_app_id,

                  :google_plus_account_url,
                  :google_plusone_locale,

                  :use_pinterest, #display pinterest?

                  :linkedin_url,

                  :github_username,

                  :admin_force_ssl,
                  :posts_per_page,
                  :admin_posts_per_page,
                  :google_analytics_id,
                  :gauge_analytics_site_id,
                  :layout,
                  :sidebar,
                  :preview_size

    def initialize
      @preview_size = 1000;

      @site_name = 'My blog'
      @site_subtitle = 'my own place online'
      @site_url = 'https://www.inimei.net'

      @meta_description = "I don't know!!"
      @meta_keyword = 'music, fun'

      @admin_force_ssl = true
      @posts_per_page = 10
      @preview_size = 1000

      @disqus_shortname = 'my_disqus_shortname'
      @sidebar = ['latest_posts', 'latest_tweets', 'categories', 'tag_cloud']

    end

    def add_class(name)
      self.instance_variable_set "@#{name}", Set.new

      create_method("#{name}=".to_sym) { |val|
        instance_variable_set("@" + name, val)
      }

      create_method(name.to_sym) do
        instance_variable_get("@" + name)
      end
    end

    private

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

  end

  def self.config(&block)
   # yield(Rails.application.config.blog)
  end

  Config = Configuration.new

  def self.table_name_prefix
    'blog_'
  end


end