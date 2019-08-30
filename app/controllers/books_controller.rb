class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]
  
  
  def new
    @book = Book.new
  end

  def create
  end

  def destroy
  end

  def search
  end

  def edit
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :author, :review)
  end
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end
  
end
