class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

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

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
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
