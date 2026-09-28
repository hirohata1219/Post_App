require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @post = posts(:one)

    post login_url, params: {
      email: @admin.email,
      password: "password"
    }
  end

  test "should get index" do
    get admin_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_post_url(@post)
    assert_response :success
  end
end