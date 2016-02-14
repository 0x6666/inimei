class AuthInfo < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  has_secure_password

  belongs_to :user

  validates :password, presence: false, length: {minimum: 6}

  before_create :create_activation_digest

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # new random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # for remember me
  def remember
    self.remember_token = AuthInfo.new_token
    update_attribute(:remember_digest, AuthInfo.digest(self.remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self.user).deliver_now
  end

  def create_reset_digest
    self.reset_token = AuthInfo.new_token
    update_columns(reset_digest: AuthInfo.digest(self.reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_emil
    UserMailer.password_reset(self.user).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  def create_activation_digest
    self.activation_token = AuthInfo.new_token
    self.activation_digest = AuthInfo.digest(self.activation_token)
  end
end
