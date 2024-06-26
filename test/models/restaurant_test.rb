require "test_helper"

class RestaurantTest < ActiveSupport::TestCase

  setup do
    @restaurant = Restaurant.new(name: "Example Restaurant", address: "123 Main St", city: "Townsville", state: "NY", zip: "12345")
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "restaurant attributes must not be empty" do
    restaurant = Restaurant.new
    assert restaurant.invalid?
    assert restaurant.errors[:name].any?
    assert restaurant.errors[:address].any?
    assert restaurant.errors[:city].any?
    assert restaurant.errors[:state].any?
    assert restaurant.errors[:zip].any?

    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
  end

  test "zip code should be in the correct format" do
    invalid_zips = %w[1234 123456 ABCDE 1234A]
    invalid_zips.each do |invalid_zip|
      @restaurant.zip = invalid_zip
      assert @restaurant.invalid?, "#{invalid_zip.inspect} should be invalid"
    end

    @restaurant.zip = "12345"
    assert @restaurant.valid?
  end

  test "city should contain only letters" do
    invalid_cities = ["Townsville1", "Townsville-123", "123Townsville"]
    invalid_cities.each do |invalid_city|
      @restaurant.city = invalid_city
      assert @restaurant.invalid?, "#{invalid_city.inspect} should be invalid"
    end

    @restaurant.city = "Townsville"
    assert @restaurant.valid?
  end

  test "name should start with a letter" do
    @restaurant.name = "1st Restaurant"
    assert @restaurant.invalid?, "Name starting with a digit should be invalid"

    @restaurant.name = "Restaurant"
    assert @restaurant.valid?, "Name starting with a letter should be valid"
  end

   test "should count split votes correctly" do
    assert_equal 0, @restaurant.will_split_vote_count
    Vote.create(user: @user1, restaurant: @restaurant, split: true)
    assert_equal 1, @restaurant.will_split_vote_count
  end

  test "should count non-split votes correctly" do
    assert_equal 0, @restaurant.wont_split_vote_count
  end

  test "should return true if user has voted for the restaurant" do
    Vote.create(user: @user1, restaurant: @restaurant, split: true)
    assert @restaurant.voted_by?(@user1)
  end

  test "should return false if user has not voted for the restaurant" do
    assert_not @restaurant.voted_by?(@user2)
  end

  test "should return true if user has favorited the restaurant" do
    favorite = Favorite.create(user: @user1, restaurant: @restaurant)
    assert @restaurant.favorited_by?(@user1)
  end

  test "should return false if user has not favorited the restaurant" do
    assert_not @restaurant.favorited_by?(@user2)
  end
end
