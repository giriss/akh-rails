require 'test_helper'

class LearnControllerTest < ActionController::TestCase
  test "should get lesson1" do
    get :lesson1
    assert_response :success
  end

  test "should get lesson2" do
    get :lesson2
    assert_response :success
  end

  test "should get lesson3" do
    get :lesson3
    assert_response :success
  end

end
