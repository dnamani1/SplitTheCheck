require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @restaurant = restaurants(:one)
    @favorite = favorites(:one)
  end

  test "should create favorite" do
    #assert_difference("Favorite.count", 1) do
      #post favorites_url, params: { favorite: { restaurant_id: @restaurant.id } }
    #end

    #assert_redirected_to restaurant_url(@restaurant)
  end

  test "should not create favorite for non-existent restaurant" do
    assert_no_difference("Favorite.count") do
      post favorites_url, params: { favorite: { restaurant_id: 0 } }
    end

    assert_redirected_to root_path
  end

  test "should destroy favorite" do
    assert_difference("Favorite.count", -1) do
      delete favorite_url(@favorite)
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should not destroy non-existent favorite" do
    assert_no_difference("Favorite.count") do
      delete favorite_url(0)
    end

    assert_redirected_to restaurants_url
  end

  test "should redirect when trying to access favorite without signing in" do
    sign_out @user

    get favorites_url
    assert_redirected_to new_user_session_path
  end

end





































































































