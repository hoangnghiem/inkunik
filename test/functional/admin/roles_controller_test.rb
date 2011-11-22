require 'test_helper'

class Admin::RolesControllerTest < ActionController::TestCase
  setup do
    @admin_role = admin_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_role" do
    assert_difference('Admin::Role.count') do
      post :create, :admin_role => @admin_role.attributes
    end

    assert_redirected_to admin_role_path(assigns(:admin_role))
  end

  test "should show admin_role" do
    get :show, :id => @admin_role.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_role.to_param
    assert_response :success
  end

  test "should update admin_role" do
    put :update, :id => @admin_role.to_param, :admin_role => @admin_role.attributes
    assert_redirected_to admin_role_path(assigns(:admin_role))
  end

  test "should destroy admin_role" do
    assert_difference('Admin::Role.count', -1) do
      delete :destroy, :id => @admin_role.to_param
    end

    assert_redirected_to admin_roles_path
  end
end
