class AddDefaultBlogSetting < ActiveRecord::Migration

  class User < ActiveRecord::Base
    has_one :blog_setting, class_name: 'Blog::Setting', dependent: :destroy
  end

  class Blog::Setting < ActiveRecord::Base
    belongs_to :user, class_name: 'User'
  end

  def up

    User.all.each do | user |
      if user.blog_setting.nil?
        Blog::Setting.create!(user_id: user.id, domain: "inimeiblog-#{user.id}");
      end
    end
  end

  def down
    User.all.each do | user |
      user.blog_setting.destroy if (!user.blog_setting.nil?)
    end
  end
end
