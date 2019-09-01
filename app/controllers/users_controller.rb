class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :goodings]
  
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.order(id: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  #Sign up
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '新規登録に成功しました。'
      redirect_to login_url
    else
      flash.now[:danger] = '新規登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @book = current_user.books.find_by(id: params[:id])
    @book.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
