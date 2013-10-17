require 'test_helper'

class PaypalControllerTest < ActionController::TestCase
  test "should get masspay" do
    get :masspay
    assert_response :success
  end

  test "should get expresscheckout" do
    get :expresscheckout
    assert_response :success
  end

end
