require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the new user page" do
    visit new_user_url

    assert_selector "h1"
  end
end
