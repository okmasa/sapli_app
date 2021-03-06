class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    @user = current_user
    @feed_items = current_user.feed.paginate(page: params[:page])
    if @micropost.save
      flash[:success] = "投稿が完了しました！"
      redirect_to microposts_user_path(current_user)
      # redirect_to request.referrer || root_url
    else
      flash[:danger] = "無効な投稿です"
      # redirect_to root_url
      redirect_to microposts_user_path(current_user)
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end