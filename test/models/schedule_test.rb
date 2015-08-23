require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @schedule= @user.schedules.build(title: 'test', content: 'what can I do?')
  end

  test 'should be valid' do
    assert @schedule.valid?
  end

  test 'user id should be present' do
    @schedule.user_id = nil
    assert_not @schedule.valid?
  end

  test 'title should at most 50 characters' do
    @schedule.title = 'a' * 51
    assert_not @schedule.valid?
  end

  test 'at least one of title and content be present' do
    @schedule.title = ' '
    @schedule.content= ' '
    assert_not @schedule.valid?
  end
end
