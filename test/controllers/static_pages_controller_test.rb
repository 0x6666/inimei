require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @base_title = 'INiMei'
  end

  test 'should get home' do
    get :home
    assert_response :redirect
    if is_logged_in?
      assert_select 'title', full_title('Home')
    #else
      #assert_select 'title', full_title('About')
    end

  end

  test 'should get help' do
    get :help
    assert_response :success
    assert_select 'title', "Help | #{@base_title}"
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', "About | #{@base_title}"
  end

  test 'should get contact' do
    get :contact
    assert_response :success
    assert_select 'title', "Contact | #{@base_title}"
  end
end
