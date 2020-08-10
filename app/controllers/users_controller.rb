class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers, :reviews,
                                        :favorites, :microposts]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 12)
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 5)
    @feed_items = @user.feed.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.img.attach(params[:user][:img])
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールを確認してアカウントを有効化してください"
      redirect_to root_url
    else
      flash[:danger] = "エラーを確認してください"
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def following
    @title = "フォローしているユーザー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page:params[:page], per_page: 20)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page:params[:page], per_page: 20)
    render 'show_follow'
  end

  def reviews
    @title = "サプリ評価一覧"
    @user  = User.find(params[:id])
    @reviews = @user.reviews.paginate(page:params[:page], per_page: 20)
    render 'show_reviews'
  end

  def favorites
    @title = "お気に入りサプリ一覧"
    @user  = User.find(params[:id])
    @supplements = @user.favorite_supplements.paginate(page:params[:page], per_page: 12)
    render 'show_favorites'
  end

  def microposts
    @title = "投稿一覧"
    @user  = User.find(params[:id])
    @micropost  = current_user.microposts.build
    @microposts = @user.microposts.paginate(page:params[:page])
    render 'show_microposts'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :img)
    end
    
    #beforeアクション

    # 正しいユーザか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end