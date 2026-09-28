require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:taro)

    post login_url, params: {
      email: @admin.email,
      password: "password"
    }
  end

  test "should get index" do
    get admin_users_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_user_url(@user)
    assert_response :success
  end
end