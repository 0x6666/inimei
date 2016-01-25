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

=begin
  test 'blog name should not be too long' do
    @setting.blog_name= 'a' * 51
    assert_not @setting.valid?
  end

  test 'blog subtitle should not be too long' do
    @setting.blog_subtitle= 'a' * 151
    assert_not @setting.valid?
  end

  test 'blogs_per_page should not be too long and not be to short' do
    @setting.blogs_per_page= 0
    assert_not @setting.valid?

    @setting.blogs_per_page= 101
    assert_not @setting.valid?
  end


  test 'blog_preview_size should not be too long and not be to short' do
    @setting.blog_preview_size= 9
    assert_not @setting.valid?

    @setting.blog_preview_size= 1001
    assert_not @setting.valid?
  end
=end

end
