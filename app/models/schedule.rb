class Schedule < ActiveRecord::Base

  belongs_to :user

  #validates
  validates :user_id, presence: true
  validates :title, length: {maximum: 50}
  validates :title, presence: true, if: :require_title_presence?
  validates :content, presence: true, if: :require_content_presence?

  private
  def require_title_presence?
    !self.content?
  end

  def require_content_presence?
    !self.title?
  end

end
