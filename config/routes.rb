Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  
  #Signup
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :destroy] do
    member do
     get :goodings
    end
  end
  
  #Login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #投稿
  resources :books, only: [:new, :create, :edit]
  get 'books/newer', to: 'books#newer'
  get 'books/search', to: 'books#search'
  post 'books/search', to: 'books#search_create'
  
  resources :goods, only: [:create, :destroy]
end
