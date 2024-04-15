class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show ]
  before_action :authenticate_user!

  # GET /votes or /votes.json
  def index
    @votes = current_user.votes.includes(:restaurant)
  end

  # GET /votes/1 or /votes/1.json
  def show
  end
  
  # POST /votes or /votes.json
  def create
     # Ensure that we're finding the restaurant by ID passed in the parameters
    restaurant = Restaurant.find(vote_params[:restaurant_id])

    # Check if the current user has already voted for this restaurant
    existing_vote = restaurant.votes.find_by(user: current_user)

    respond_to do |format|
      if existing_vote
        format.html { redirect_to restaurant, alert: "You have already voted for this restaurant." }
        format.json { render json: { error: "You have already voted for this restaurant." }, status: :forbidden }
      else
        # We don't need to pass user_id in the parameters since we're already
        # getting the current_user from the devise helper
        @vote = restaurant.votes.build(vote_params.merge(user: current_user))

        if @vote.save
          format.html { redirect_to restaurant, notice: "Your vote was successfully recorded." }
          format.json { render :show, status: :created, location: @vote }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @vote.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:user_id, :restaurant_id, :split)
    end
end
