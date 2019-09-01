class GoodsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    book = Book.find(params[:book_id])
    current_user.good(book)
    flash[:success] = '投稿にいいねをしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.ungood(book)
    flash[:success] = '投稿のいいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
