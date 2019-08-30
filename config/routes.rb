Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  
  #Signup
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  #Login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #投稿
  resources :books, only: [:new, :create, :edit, :destroy]
  get 'books/newer', to: 'books#newer'
end

#次、投稿