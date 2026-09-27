require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "should get edit" do
    token = users(:taro).generate_token_for(:password_reset)
    get edit_password_reset_url(token: token)
    assert_response :success
  end
end
