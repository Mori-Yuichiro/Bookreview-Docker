class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]
  
  
  def new
    @book = Book.new
    @kinds = Kind.all
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'books/edit'
    end
  end
  
  #楽天APIでの検索
  def search
    @book = Book.new
    
    @books = []
    
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 20,
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book 
      end
    end
  end
  
  def search_create
    #その商品を検索し、保存されてなければItem.newを実行
    @book = Book.find_or_initialize_by(image_url: params[:image_url])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(image_url: @book.image_url)
      @book = Book.new(read(results.first))
      @book.save
    end
    
    redirect_to new_book_url
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
  
  def read(result)
    title = result['title']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    
    {
      title: title,
      isbn: isbn,
      image_url: image_url,
    }
  end
end
