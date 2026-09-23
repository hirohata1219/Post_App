require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "create user successfully" do
    assert_difference("User.count", 1) do
      post users_path, params: {
        user: {
          name: "Taro",
          email: "new-user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to login_path
    assert_equal "新規登録に成功しました", flash[:notice]
  end

  test "render new when user creation fails" do
    assert_no_difference("User.count") do
      post users_path, params: {
        user: {
          name: "",
          email: "new-user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_equal "新規登録に失敗しました", flash[:alert]
  end
end
