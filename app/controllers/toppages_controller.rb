class ToppagesController < ApplicationController
  def index
    if logged_in?
      @books = Book.all.order(id: :desc)
      @kinds = Kind.all
      
      #グラフ描画のためのハッシュ作成
      chart = {}
      for num in (1..5) do
        kind = Kind.find_by(id: num)
        book = Book.where(kind_id: num)
        kind_count = book.count
        
        @chart = chart.merge!(kind.name => kind_count )
      end
    end
  end
end
