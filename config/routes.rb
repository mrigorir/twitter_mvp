Rails.application.routes.draw do

  root 'sessions#new'
  get '/home', to: 'opinions#index'
 
end