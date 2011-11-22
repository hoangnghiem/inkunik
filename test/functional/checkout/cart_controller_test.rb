require 'test_helper'

class Checkout::CartControllerTest < ActionController::TestCase
  test "should get cart" do
    get :add_to_cart
    assert_response :success
  end

  test "should get update_quantity" do
    get :update_quantity
    assert_response :success
  end

end
