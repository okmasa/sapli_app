class GuestSessionsController < ApplicationController

  def create
    user = User.find_by(email: 'guest@sapliapli.com')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    redirect_to root_path
  end
end
