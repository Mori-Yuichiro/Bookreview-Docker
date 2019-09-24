Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  get 'toppages/about', to: 'toppages#about'
  
  #Signup
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
    member do
     get :goodings
    end
  end
  
  #Login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #投稿
  resources :books, only: [:new, :create, :edit, :destroy] do
    collection do
      get :search
    end
  end
  post 'books/index', to: 'books#index'
  post 'books/new', to: 'books#new'
  post 'books/create', to: 'books#create'
  get 'books/good', to: 'books#good'
  
  get 'kinds/:id', to: 'kinds#show'
  
  resources :goods, only: [:create, :destroy]
end
