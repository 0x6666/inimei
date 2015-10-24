require 'test_helper'

class SubScheduleTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @schedule = @user.schedules.first
    @subSchedule = @schedule.sub_schedules.build(content: 'test')
  end

  test 'should be valid' do
    assert @subSchedule.valid?
  end

  test 'schedule id should be present' do
    @subSchedule.schedule_id = nil
    assert_not @subSchedule.valid?
  end

  test 'content should at most 100 characters' do
    @subSchedule.content = 'a' * 101
    assert_not @subSchedule.valid?
  end

end
