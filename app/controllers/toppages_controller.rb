class ToppagesController < ApplicationController
  def index
    if logged_in?
      @books = Book.order(id: :desc).page(params[:page])
    end
  end
end
