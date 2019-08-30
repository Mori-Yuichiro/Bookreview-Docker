class ToppagesController < ApplicationController
  def index
    if logged_in?
      
      @books = current_user.books.order(id: :desc).page(params[:page])
    end
  end
end
