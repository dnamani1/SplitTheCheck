class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]
  before_action :authenticate_user!

  # POST /favorites or /favorites.json
  def create
    @favorite = current_user.favorites.build(restaurant_id: params[:restaurant_id])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_back(fallback_location: root_path, notice: 'Restaurant was successfully marked as favorite.') }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { redirect_back(fallback_location: root_path, alert: 'Could not mark as favorite.') }
        Rails.logger.error "Favorite creation error: #{@favorite.errors.full_messages.join(", ")}"
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])

    if @favorite
      @restaurant = @favorite.restaurant
      @favorite.destroy

      respond_to do |format|
        format.html { redirect_back(fallback_location: restaurant_path(@restaurant), notice: 'Favorite successfully removed.') }
        format.json { head :no_content }
      end
    else
      redirect_back(fallback_location: restaurants_url, alert: 'Favorite not found.')
    end
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find_by(id: params[:id])
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :restaurant_id)
  end
end

