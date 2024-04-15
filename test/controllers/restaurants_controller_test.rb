require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:one)  # Use the fixture named 'one'
    @user = users(:one)           # Assuming you have a user fixture as well
    sign_in @user 
  end

  test "should route to restaurants index" do
    assert_routing '/restaurants', controller: "restaurants", action: "index"
  end

  test "should route to new restaurant" do
    assert_routing '/restaurants/new', controller: "restaurants", action: "new"
  end

  test "should route to create restaurant" do
    assert_routing({ method: 'post', path: '/restaurants' }, { controller: "restaurants", action: "create" })
  end

  test "should route to edit restaurant" do
    assert_routing '/restaurants/1/edit', controller: "restaurants", action: "edit", id: "1"
end
  
  test "should get index with all restaurants" do
    get restaurants_url
    assert_response :success
    assert_select 'td', text: 'Pizza Place'
    assert_select 'td', text: 'Burger Joint'
  end

  test "should get index with search by name" do
    get restaurants_url, params: { search: "Pizza", search_by: "name" }
    assert_response :success
    assert_select 'td', text: 'Pizza Place'
    assert_select 'td', text: 'Burger Joint', count: 0
  end

  test "should get index with search by zip" do
    get restaurants_url, params: { search: "67890", search_by: "zip" }
    assert_response :success
    assert_select 'td', text: 'Burger Joint'
    assert_select 'td', text: 'Pizza Place', count: 0
  end

  test "should redirect with notice when no records found" do
    get restaurants_url, params: { search: "Nonexistent", search_by: "name" }
    assert_redirected_to new_restaurant_path
    follow_redirect!
    assert_select 'p#notice', text: "No records found. Please add the restaurant so that others can find it."
  end

  test "should not create restaurant with invalid attributes" do
    assert_no_difference("Restaurant.count") do
      post restaurants_url, params: { restaurant: { name: '', address: '', city: '', state: '', zip: 'abcde' } }
    end
    assert_response :unprocessable_entity
  end

  test "vote without selecting option should redirect with notice" do
    assert_no_changes '@restaurant.reload.will_split_vote_count' do
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
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, zip: @restaurant.zip } }
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
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, zip: @restaurant.zip } }
    assert_redirected_to restaurant_url(@restaurant)
  end
end
