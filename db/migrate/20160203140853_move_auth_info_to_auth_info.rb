class MoveAuthInfoToAuthInfo < ActiveRecord::Migration
  class User < ActiveRecord::Base
    has_one :auth_info, dependent: :destroy
  end

  class AuthInfo < ActiveRecord::Base
    belongs_to :user
  end

  def up
    User.all.each do | user |
      if user.auth_info.nil?
        AuthInfo.create!(user_id: user.id,
                         password_digest: user.password_digest,
                         remember_digest: user.remember_digest,
                         activation_digest: user.activation_digest,
                         activated: user.activated,
                         activated_at: user.activated_at,
                         reset_digest: user.reset_digest,
                         reset_sent_at: user.reset_sent_at)
      else
        user.auth_info.password_digest = user.password_digest
        user.auth_info.remember_digest = user.remember_digest
        user.auth_info.activation_digest = user.activation_digest
        user.auth_info.activated = user.activated
        user.auth_info.activated_at = user.activated_at
        user.auth_info.reset_digest = user.reset_digest
        user.auth_info.reset_sent_at = user.reset_sent_at
      end
    end
    remove_columns :users,
                   :password_digest,
                   :remember_digest,
                   :activation_digest,
                   :activated,
                   :activated_at,
                   :reset_digest,
                   :reset_sent_at
  end

  def down
    # todo
  end
end
