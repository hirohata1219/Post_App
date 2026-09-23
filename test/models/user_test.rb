require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = users(:taro)

    assert user.valid?
  end

  test "name is required" do
    user = User.new(
      name: nil,
      email: "test@example.com",
      password: "password"
    )

    assert_not user.valid?
  end

  test "email is required" do
    user = User.new(
      name: "Taro",
      email: nil,
      password: "password"
    )

    assert_not user.valid?
  end

  test "email must be unique" do
    user = users(:taro)

    another_user = User.new(
      name: "Jiro",
      email: user.email,
      password: "password"
    )

    assert_not another_user.valid?
  end

  test "email must be valid format" do
    user = User.new(
      name: "Taro",
      email: "invalid-email",
      password: "password"
    )

    assert_not user.valid?
  end

  test "password is required when creating a user" do
    user = User.new(
      name: "Taro",
      email: "test@example.com",
      password: nil
    )

    assert_not user.valid?
  end

  test "password must be at least 3 characters" do
    user = User.new(
      name: "Taro",
      email: "test@example.com",
      password: "ab"
    )

    assert_not user.valid?
  end

  test "password can be changed for existing user" do
    user = users(:taro)

    user.password = "newpassword"

    assert user.valid?
  end

  test "authenticate returns user with correct password" do
    user = users(:taro)

    assert_equal user, user.authenticate("password")
  end

  test "authenticate returns false with incorrect password" do
    user = users(:taro)

    assert_not user.authenticate("wrong")
  end
end
