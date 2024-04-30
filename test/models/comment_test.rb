require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @restaurant = Restaurant.create!(
      name: "Test Restaurant",
      address: "123 Main St",
      city: "City",
      state: "TX",
      zip: "12345"
    )
  end

  test "should be valid with valid attributes" do
    comment = Comment.new(
      content: "This is a great restaurant!",
      user: @user,
      restaurant: @restaurant
    )
    assert comment.valid?
  end

  test "should not be valid without content" do
    comment = Comment.new(
      user: @user,
      restaurant: @restaurant
    )
    assert_not comment.valid?
    assert_includes comment.errors[:content], "can't be blank"
  end

  test "should belong to a user" do
    comment = Comment.new(
      content: "This is a great restaurant!",
      restaurant: @restaurant
    )
    assert_not comment.valid?
    assert_includes comment.errors[:user], "must exist"
  end

  test "should belong to a restaurant" do
    comment = Comment.new(
      content: "This is a great restaurant!",
      user: @user
    )
    assert_not comment.valid?
    assert_includes comment.errors[:restaurant], "must exist"
  end
end

