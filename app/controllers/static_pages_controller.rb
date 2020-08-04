class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    # ランキング機能
    # @ranks = Supplement.find(Review.group(:supplement_id).average(:score).order('average(:score) desc').take(3).pluck(:supplement_id))
    # @rank = Supplement.find(Review.group(:supplement_id, :score).order('average_score DESC').average(:score).limit(3).pluck(:supplement_id))
    # @sum = Review.group(:supplement_id).o
    # averages = Review.select("supplement_id,avg(score) as avg").group(:supplement_id)
    # @rank = order('@ave DESC').limit(3).pluck(:supplement_id)
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