require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    post login_url, params: {
      email: "taro@example.com",
      password: "password"
    }

    get profile_url
    assert_response :success
  end

  test "should get edit" do
    post login_url, params: {
      email: "taro@example.com",
      password: "password"
    }

    get edit_profile_url
    assert_response :success
  end
end
