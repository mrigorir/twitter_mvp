
Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :edit, :update]
  
  get '/login'  , to: 'sessions#new'
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/home', to: 'opinions#index'
  get '/signup', to: 'users#new'
  
end