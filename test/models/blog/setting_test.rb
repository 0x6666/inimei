require 'test_helper'

class Blog::SettingTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @yangsong = users(:yangsong)
    @setting = @user.blog_setting
  end

  test 'should be valid' do
    assert @setting.valid?
  end

  test 'domain should be unique' do
    setting = @user.blog_setting
    setting.domain = @yangsong.blog_setting.domain
    setting.save

    assert_not setting.valid?
  end

  test 'domain should be save as lower case' do
    mix_case_domain = 'AAYUIJKMLAABHFJSLKFDS'
    @setting.domain = mix_case_domain
    @setting.save
    @setting.reload
    assert @setting.domain == mix_case_domain.downcase
  end

end
