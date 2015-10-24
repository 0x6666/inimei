class Schedule < ActiveRecord::Base

  belongs_to :user
  default_scope -> { order(planed_completed_at: :desc) }

  has_many :sub_schedules, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}

  def complete
    update_columns(completed: true, completed_at: Time.zone.now)
  end

  def uncomplete
    update_columns(completed: false, completed_at: nil)
  end

end
