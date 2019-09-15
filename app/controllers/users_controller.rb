class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :goodings]
  
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.order(id: :desc)
    @kinds = Kind.all
    
    #グラフの描画のためのハッシュ作成
    chart = {}
    for num in (1..5) do
      kind = Kind.find_by(id: num )
      book = @user.books.where(kind_id: num)
      kind_count = book.count
      
      @chart = chart.merge!(kind.name => kind_count)
    end
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
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
