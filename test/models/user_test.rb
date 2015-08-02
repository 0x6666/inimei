require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new name: 'Test Name', email: 'testname@test.com',
                     password: 'test_a', password_confirmation: 'test_a'
  end


  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '       '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email= ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name= 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email= 'a' * 256
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@example.Com ys_so-fd@inimei.com first.second@inimei.com]
    valid_addresses.each do |addr|
      @user.email= addr
      assert @user.valid?, "#{addr.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[ys@user..com user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email= @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length' do
    @user.password= @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'email should be save as lower case' do
    mix_case_email = 'YsonJ@inimei.Com'
    @user.email=mix_case_email
    @user.save
    @user.reload
    assert_not @user.email == mix_case_email
  end

  test 'authenticated? should return false for user with nil digest' do
    assert_not @user.authenticated? :remember, ''
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Lorem ipsum')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end

