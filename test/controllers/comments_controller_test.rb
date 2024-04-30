require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = users(:one)
    sign_in @user
    @restaurant = restaurants(:one)
    @comment = comments(:one)
  end

  test "should create comment" do
    restaurant = @restaurant
    restaurant_id = restaurant.id
    assert_difference("Comment.count", 1) do
      post comments_url, params: { comment: { content: "A valid comment", restaurant_id: restaurant_id} }
    end

    assert_redirected_to restaurant_url(restaurant)
  end

  test "should not create comment without restaurant" do
    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { content: "A valid comment", restaurant_id: 0 } }
    end

    assert_redirected_to root_path
  end

  test "should not create comment without content" do
    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { content: "", restaurant_id: @restaurant.id } }
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

end
