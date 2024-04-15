require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @restaurant = restaurants(:one) 
    sign_in @user1
  end

  test "should get index" do
    get votes_url
    assert_response :success
  end

  test "signed out should not get index" do
    sign_out @user1
    get votes_url
    assert_redirected_to new_user_session_path
  end

  test "should get new" do
    get new_vote_url
    assert_response :success
  end

  test "signed out should not get new" do
    sign_out @user1
    get new_vote_url
    assert_redirected_to new_user_session_path
  end

  test "should create vote" do
    Vote.where(user: @user1, restaurant: @restaurant).delete_all
    assert_difference("Vote.count", 1) do
      post votes_url, params: { vote: { restaurant_id: @restaurant.id, split: true } }
    end
    assert_redirected_to restaurant_path(@restaurant)
  end

  test "signed out should not create vote" do
    sign_out @user1
    post votes_url, params: { vote: { restaurant_id: @restaurant.id, split: true } }
    assert_redirected_to new_user_session_path
  end

  test "should show vote" do
    vote = votes(:one)
    get vote_url(vote)
    assert_response :success
  end

  test "should not allow a user to vote twice for the same restaurant" do
    post votes_url, params: { vote: { restaurant_id: @restaurant.id, split: true } }
    assert_no_difference('Vote.count') do
      post votes_url, params: { vote: { restaurant_id: @restaurant.id, split: true } }
    end
    assert_redirected_to restaurant_path(@restaurant.id)
    follow_redirect!
    assert_match /already voted/, response.body
  end

  test "should require user to be logged in" do
    sign_out @user1
    get votes_url
    assert_redirected_to new_user_session_path
  end

  test "will_split_vote_count returns correct tally" do
    restaurant = Restaurant.create!(name: "Test Restaurant 1", address: "123 Main St", city: "Town", state: "NY", zip: "12345")
    user1 = users(:one)
    user2 = users(:two)
    user3 = users(:three)

    Vote.create!(restaurant: restaurant, user: user1, split: true)
    Vote.create!(restaurant: restaurant, user: user2, split: true)
    Vote.create!(restaurant: restaurant, user: user3, split: false) 

    assert_equal 2, restaurant.will_split_vote_count, "There should be two votes in favor of split."
  end

  test "wont_split_vote_count returns correct tally" do
    restaurant = Restaurant.create!(name: "Test Restaurant 2", address: "123 Main St", city: "Town", state: "NY", zip: "12345")
    user1 = users(:one)
    user2 = users(:two)
    user3 = users(:three)

    Vote.create!(restaurant: restaurant, user: user1, split: false)
    Vote.create!(restaurant: restaurant, user: user2, split: false)
    Vote.create!(restaurant: restaurant, user: user3, split: true)  

    assert_equal 2, restaurant.wont_split_vote_count, "There should be two votes against split."
  end

end

