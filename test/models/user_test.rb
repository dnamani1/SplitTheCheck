require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_attributes = {
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  test "should be valid with valid attributes" do
    user = User.new(@user_attributes)
    assert user.valid?, "User should be valid with correct attributes and password confirmation"
  end

  test "should not be valid without password confirmation" do
    @user_attributes[:password_confirmation] = ""
    user = User.new(@user_attributes)
    assert_not user.valid?, "User should not be valid without password confirmation"
  end

  test "can have multiple votes" do
    user = User.create!(@user_attributes)
    restaurant1 = restaurants(:one)
    restaurant2 = restaurants(:two)
    user.votes.create!(restaurant: restaurant1, split: true)
    user.votes.create!(restaurant: restaurant2, split: false)

    assert_equal 2, user.votes.count, "User should have two votes"
  end
end
