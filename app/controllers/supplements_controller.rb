class SupplementsController < ApplicationController
  before_action :admin_user,     only: [:destroy]

  def new
    @supplement = Supplement.new
  end
  
  def index
    @supplements = Supplement.paginate(page: params[:page])
  end

  def show
    @supplement = Supplement.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to supplements_url
  end
  
  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end