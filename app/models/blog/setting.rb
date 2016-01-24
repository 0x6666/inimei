class Blog::Setting < ActiveRecord::Base
  belongs_to :user

  before_save :downcase_domain

  validates :user, presence: true
  VALID_DOMAIN_REGEX = /[a-zA-Z0-9][-a-zA-Z0-9]{0,62}/
  validates :domain, presence: true, format: {with: VALID_DOMAIN_REGEX}, uniqueness: {case_sensitive: false}

  # should ensure by module test
=begin
  validates :blog_name, length: {maximum: 50}
  validates :blog_subtitle, length: {maximum: 150}
  validates :blogs_per_page, inclusion: { in: 1..100 }
  validates :blog_preview_size, inclusion: { in: 10..1000 }
=end

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

  private
  def downcase_domain
    self.domain= domain.downcase
  end
end
