class SupplementsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :new, :create, :update]
  before_action :find_micropost, only: [:edit, :create, :show]
  before_action :admin_user,     only: [:destroy]
  
  def index
    @supplements = Supplement.paginate(page: params[:page], per_page: 9)
  end

  def new
    @supplement = Supplement.new
  end

  def create
    @supplement = Supplement.new(supplement_params)
    # 画像がなければデフォ画像を指定
    if image = params[:supplement][:img]
      @supplement.img.attach(image)
    else
      @supplement.img.attach(io: File.open("./db/fixtures/noimage.jpg"), filename: "noimage.jpg")
    end
    if @supplement.save
      flash[:info] = "サプリを登録しました"
      redirect_to supplements_path
    else
      flash[:danger] = "エラーを確認してください"
      render 'new'
    end 
  end

  def show
    @supplement = Supplement.find(params[:id])
    # debugger
    # @micropost  = @supplement.microposts.build(user_id: current_user.id)
    @review = @supplement.reviews.build(user: current_user)
    @review_item = @supplement.reviews.paginate(page: params[:page], per_page: 10)
    # @micropost.save
    # サプリの評価
    # @review_items = @supplement.microposts.build(user_id: current_user.id, created_at: Time.now)
    # @review_items = current_user.microposts.build(supplement_id: params[:id])
    # @review_items.save
    # アソシエーション使わない場合
    # @review_items = @supplement.review.paginate(page: params[:page])
    # @review_items = @supplement.microposts.paginate(page: params[:page])
    # @review_items = @micropost.paginate(page: params[:page])
  end
  
  def edit
    @supplement = Supplement.find(params[:id])
  end
  
  def update
    @supplement = Supplement.find(params[:id])
    if @supplement.update(supplement_params)
      flash[:success] = "サプリ情報を更新しました"
      redirect_to @supplement
    else
      render 'edit'
    end
  end

  def destroy
    Supplement.find(params[:id]).destroy
    flash[:success] = "サプリを削除しました"
    redirect_to supplements_url
  end
  
  private

    def supplement_params
      params.require(:supplement).permit(:name, :img, :description, :user)
    end
    
    def review_params
      params.require(:review).permit(:content, :score, :user_id)
    end

    def find_micropost
      # @micropost  = @supplement.microposts.build(user_id: current_user.id)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end