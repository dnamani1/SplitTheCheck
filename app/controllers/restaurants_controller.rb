class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  # GET /restaurants or /restaurants.json
  def index
    if params[:search].present? && params[:search_by].present?
      search_term = params[:search].downcase
      if params[:search_by] == 'name'
        @restaurants = Restaurant.where('LOWER(name) LIKE ?', "%#{search_term}%")
      elsif params[:search_by] == 'zip'
        @restaurants = Restaurant.where('zip LIKE ?', "%#{search_term}%")
      end
      if @restaurants.empty?
      redirect_to new_restaurant_path, notice: "No records found. Please add the restaurant so that others can find it."
      return
    end
    else
      @restaurants = Restaurant.all
    end
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    store_location_for(:user, request.fullpath) unless user_signed_in?
    @comments = @restaurant.comments.order(created_at: :desc)
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  def vote
    @restaurant = Restaurant.find(params[:id])
    #vote_type = params[:restaurant][:vote]
    vote_type = params[:restaurant].present? ? params[:restaurant][:vote] : nil

    if vote_type.blank?
      redirect_to @restaurant, notice: "Please select one option to vote."
      return
    end

    if vote_type == 'will_split'
      @restaurant.increment!(:will_split_vote_count)
    elsif vote_type == 'wont_split'
      @restaurant.increment!(:wont_split_vote_count)
    end

  respond_to do |format|
      #format.turbo_stream 
      format.html { redirect_to @restaurant, notice: "Vote was successfully recorded." }
    end
  end

  def summary
    @comments = Comment.all.order(created_at: :desc)
    @votes = Vote.all.group_by { |vote| vote.restaurant }
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        #puts @restaurant.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      puts @restaurant.errors.full_messages
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :will_split_vote_count, :wont_split_vote_count)
    end
end
