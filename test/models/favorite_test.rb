require "test_helper"

class FavoriteTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(
      email: "testuser@example.com",
      password: "Test@123",
      password_confirmation: "Test@123"
    )

    @restaurant = Restaurant.create!(
      name: "Sample Restaurant",
      address: "123 Main St",
      city: "City",
      state: "SC",
      zip: "12345"
    )

    @favorite = Favorite.create(user: @user, restaurant: @restaurant)
  end

  test "favorite should be valid with valid attributes" do
    assert @favorite.valid?
  end

  test "favorite should require a user" do
    @favorite.user = nil
    assert_not @favorite.valid?
    assert_includes @favorite.errors[:user], "must exist"
  end

  test "favorite should require a restaurant" do
    @favorite.restaurant = nil
    assert_not @favorite.valid?
    assert_includes @favorite.errors[:restaurant], "must exist"
  end
end

