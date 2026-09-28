require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)

    post login_url, params: {
      email: @admin.email,
      password: "password"
    }
  end

  test "should get index" do
    get admin_dashboard_index_url
    assert_response :success
  end
end
