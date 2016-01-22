class Blog::Setting < ActiveRecord::Base
  belongs_to :user

  def self.owner(subdomain)
    return nil if subdomain.nil?
    setting = Blog::Setting.find_by_domain(subdomain)
    return nil if setting.nil?
    setting.user
  end

  def self.setting(subdomain)
    return nil if subdomain.nil?
    Blog::Setting.find_by_domain(subdomain)
  end

end
