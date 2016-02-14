class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  #microposts
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #schedules
  has_many :schedules, dependent: :destroy

  #blogs
  has_many :blog_posts, class_name: 'Blog::Post', dependent: :destroy
  has_one :blog_setting, class_name: 'Blog::Setting', dependent: :destroy

  #authtication
  has_one :auth_info, dependent: :destroy

  before_save :downcase_email
  after_save :ensure_blog_setting

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  def feed
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end

  def can_delete?(user)
    return false if self==user
    return false if user.posts.any?
    true
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def ensure_blog_setting
    if self.blog_setting.nil?
      #why can't use create_blog_setting! ?
      set = self.create_blog_setting(domain: "inimeiblog-#{self.id}")
      set.save
    end
  end
end
