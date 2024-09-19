Rails.application.routes.draw do
  devise_for :users
  resource :sessions, only: [:create, :destroy]  
  resources :tasks 
end
