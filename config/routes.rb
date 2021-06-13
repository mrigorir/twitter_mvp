
Rails.application.routes.draw do
  get '/login'  , to: 'sessions#new'
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/home', to: 'opinions#index'
  get '/signup', to: 'users#new'
  get '/follow_user/:id' , to: 'users#follow_this_user', as: :follow_this_user
  get '/unfollow_user/:id' , to: 'users#unfollow_this_user', as: :unfollow_this_user
 

  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :opinions, only: [:create, :show, :index]
end