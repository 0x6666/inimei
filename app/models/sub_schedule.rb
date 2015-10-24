class SubSchedule < ActiveRecord::Base
  belongs_to :schedule

  validates :schedule_id, presence: true
  validates :content, presence: true, length: {maximum: 100}

end
