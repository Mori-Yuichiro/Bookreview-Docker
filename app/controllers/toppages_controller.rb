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
      
      #いいねの数でランキング表示
      @all_ranks = Book.find(Good.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
    end
  end
  
  def about
  end
end
