class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @supplement = Supplement.find_by(id: (params[:review][:supplement_id]))
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "評価が投稿されました！"
      redirect_to supplement_path(@supplement)
    else
      flash[:danger] = "評価の投稿に失敗しました。エラーメッセージを確認してください。"
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "サプリ評価を削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def review_params
      params.require(:review).permit(:content, :score, :supplement_id)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to supplement_path(@supplement) if @review.nil?
    end

end