require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get show" do
    get post_url(posts(:one))
    assert_response :success
  end

  test "should get new" do
    post login_url, params: {
      email: "taro@example.com",
      password: "password"
    }

    get new_post_url
    assert_response :success
  end

  test "should get edit" do
    post login_url, params: {
      email: "taro@example.com",
      password: "password"
    }

    get edit_post_url(posts(:one))
    assert_response :success
  end
end
