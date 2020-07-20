class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end
  
end