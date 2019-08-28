Rails.application.routes.draw do
  
  #トップページ
  root to: 'toppages#index'
  
  #Signup
  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :new, :create]
end
