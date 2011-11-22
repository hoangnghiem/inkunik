require 'test_helper'

class Checkout::CheckoutControllerTest < ActionController::TestCase
  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should get shipping_address" do
    get :shipping_address
    assert_response :success
  end

  test "should get shipping_method" do
    get :shipping_method
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should get review" do
    get :review
    assert_response :success
  end

end
