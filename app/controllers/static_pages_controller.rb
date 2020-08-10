class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 3 )
      @reviews = current_user.reviews.paginate(page: params[:page], per_page: 3 )
      @favorite_supplements = @user.favorite_supplements
    end
    # ランキング機能
    # @ranks = Supplement.find(Review.group(:supplement_id).average(:score).order('average(:score) desc').take(3).pluck(:supplement_id))
    #-------------------------------------------------------------------
    # idごとにスコアを平均値化
    ave = Review.group(:supplement_id).average(:score)
    # 降順にソートしてトップ３を抜き出す
    sort = Hash[ ave.sort_by{ |_, v| -v } ]
    @top_sapli = Supplement.find(sort.keys.take(3))
  end

  def about
  end
  
end