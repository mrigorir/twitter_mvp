
Rails.application.routes.draw do
  get '/login'  , to: 'sessions#new'
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/home', to: 'opinions#index'
  get '/signup', to: 'users#new'
  
  resources :users, only: [:new, :create, :show, :edit, :update]
end