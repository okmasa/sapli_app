class SupplementsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :new, :create, :update]
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
    params.require(:supplement).permit(:name, :img, :description)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end