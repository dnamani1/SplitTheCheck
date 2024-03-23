require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should not create restaurant with invalid attributes" do
    assert_no_difference("Restaurant.count") do
      post restaurants_url, params: { restaurant: { name: '', address: '', city: '', state: '', zip: 'abcde' } }
    end
    assert_response :unprocessable_entity
  end

  test "vote should increase will_split_votes" do
    assert_changes '@restaurant.reload.will_split_votes', from: @restaurant.will_split_votes, to: @restaurant.will_split_votes + 1 do
      patch vote_restaurant_url(@restaurant), params: { restaurant: { vote: 'will_split' } }
    end
    assert_redirected_to restaurant_url(@restaurant)
    follow_redirect!
    assert_match /Vote was successfully recorded/, response.body
  end

  test "vote should increase wont_split_votes" do
    assert_changes '@restaurant.reload.wont_split_votes', from: @restaurant.wont_split_votes, to: @restaurant.wont_split_votes + 1 do
      patch vote_restaurant_url(@restaurant), params: { restaurant: { vote: 'wont_split' } }
    end
    assert_redirected_to restaurant_url(@restaurant)
    follow_redirect!
    assert_match /Vote was successfully recorded/, response.body
  end

  test "vote without selecting option should redirect with notice" do
    assert_no_changes '@restaurant.reload.will_split_votes' do
      patch vote_restaurant_url(@restaurant), params: { restaurant: { vote: '' } }
    end
    assert_redirected_to restaurant_url(@restaurant)
    follow_redirect!
    assert_match /Please select one option to vote/, response.body
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference("Restaurant.count") do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, will_split_votes: @restaurant.will_split_votes, wont_split_votes: @restaurant.wont_split_votes, zip: @restaurant.zip } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, will_split_votes: @restaurant.will_split_votes, wont_split_votes: @restaurant.wont_split_votes, zip: @restaurant.zip } }
    assert_redirected_to restaurant_url(@restaurant)
  end
end
