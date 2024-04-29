class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show ]
  before_action :authenticate_user!, except: [:index, :show]

  # POST /comments or /comments.json
  def create
    @restaurant = Restaurant.find_by(id: params[:comment][:restaurant_id])
  if @restaurant.nil?
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, alert: "Restaurant not found.") }
      format.json { render json: { error: "Restaurant not found" }, status: :not_found }
    end
    return
  end

  @comment = current_user.comments.new(comment_params.merge(restaurant: @restaurant))

  respond_to do |format|
    if @comment.save
      format.html { redirect_back(fallback_location: restaurant_path(@restaurant), notice: "Comment was successfully created.") }
      format.json { render :show, status: :created, location: @comment }
    else
      format.html { redirect_back(fallback_location: restaurant_path(@restaurant), alert: "Comment could not be created.") }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
