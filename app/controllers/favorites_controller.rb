class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(supplement_id: params[:supplement_id])
    favorite.save
    @supplement = Supplement.find_by(id: params[:supplement_id])
    # redirect_to supplement_path(@supplement)
    respond_to do |format|
      format.html { redirect_to supplement_path(@supplement) }
      format.js
    end
  end
  
  def destroy
    favorite = Favorite.find_by(supplement_id: params[:supplement_id], user_id: current_user.id)
    favorite.destroy
    @supplement = Supplement.find_by(id: params[:supplement_id])
    # redirect_to supplement_path(@supplement)
    respond_to do |format|
      format.html { redirect_to supplement_path(@supplement) }
      format.js
    end
  end
end
