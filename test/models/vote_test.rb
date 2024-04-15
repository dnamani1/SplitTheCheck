require "test_helper"

class VoteTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @restaurant = restaurants(:one)
    @other_restaurant = restaurants(:two)  # Make sure you have a second restaurant.
    
    Vote.delete_all  # Clear votes to prevent state leakage between tests.
  end

  test "should be valid with valid attributes" do
    vote = Vote.new(user: @user, restaurant: @restaurant, split: true)
    assert vote.valid?, "Vote should be valid with all required attributes"
  end

  test "user should not vote twice for the same restaurant" do
    Vote.create!(user: @user, restaurant: @restaurant, split: true)
    duplicate_vote = Vote.new(user: @user, restaurant: @restaurant, split: true)
    assert_not duplicate_vote.valid?, "Should not allow a user to vote twice for the same restaurant"
  end

  test "user can vote for different restaurants" do
    Vote.create!(user: @user, restaurant: @restaurant, split: true)
    new_vote = Vote.new(user: @user, restaurant: @other_restaurant, split: false)
    assert new_vote.valid?, "User should be able to vote for different restaurants"
  end
end
