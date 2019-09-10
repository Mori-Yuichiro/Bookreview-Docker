class ToppagesController < ApplicationController
  def index
    if logged_in?
      @books = Book.all.order(id: :desc)
      @kinds = Kind.all
    end
  end
end
