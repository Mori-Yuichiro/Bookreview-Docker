class BooksController < ApplicationController
  before_action :require_user_logged_in, only: [:newer, :good]
  before_action :correct_user, only: [:edit, :destroy]
  before_action :kinds, only: [:search, :index, :new, :newer, :good]
  
  include ChangeIsbnHelper
  
  
  #楽天APIでの検索
  def search
    @book = current_user.books.build
  end
    
  def index  
    @book = current_user.books.build
    
    @books = []
    
    @title = params[:book][:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 10,
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book 
      end
    end
  end
  
  
  def new
    @book1 = current_user.books.find_or_initialize_by(isbn: params[:isbn])
    
    unless @book1.persisted?    #persisted? : Active Record object がDB に保存済みかどうかを判定するメソッド
      results = RakutenWebService::Books::Book.search({isbn: @book1.isbn})
      
      @book1 = Book.new(read(results.first))
    end
  end
  
  def create
    
    #その商品を検索し、保存されてなければBook.newを実行
    @book1 = current_user.books.find_or_initialize_by(isbn: params[:isbn])
    unless @book1.persisted?     #persisted? : Active Record object がDB に保存済みかどうかを判定するメソッド
      results = RakutenWebService::Books::Book.search({isbn: @book1.isbn})
      
      @book2 = Book.new(read(results.first))
      Rails.logger.info(@book2)
      @book2.user_id = current_user.id
      @book2.kind_id = params[:book][:kind_id]
      @book2.review = params[:book][:review]
      @book2.isbn = change_isbn(params[:isbn])
      
      if @book2.save
        flash[:success] = 'レビューを投稿しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'レビューの投稿に失敗しました。'
        @book1 = Book.new(read(results.first))
        @book1.kind_id = params[:book][:kind_id]
        @kinds = Kind.all
        render :new
      end
    end
  end

  def destroy
    @book.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  def good
    @goods = current_user.goodings.order(id: :desc)
    
    #グラフ描画のためのハッシュ作成
    chart = {}
    good_books = current_user.goodings
    for num in (1..5) do
      kind = Kind.find_by(id: num)
      good_kind = good_books.where(kind_id: num)
      good_count = good_kind.count
      
      @chart = chart.merge!(kind.name => good_count)
    end
  end
  
  
  
  private
  
  
  def kinds
    @kinds = Kind.all
  end
  
  def read(result)
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '') #gsub(A,B) : 文字列置換。Aに置換前の文字列、Bに置換後の文字列
    itemUrl = result['itemUrl']
    
    {
      title: title,
      author: author,
      isbn: isbn,
      image_url: image_url,
      itemUrl: itemUrl,
    }
  end
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end
end
