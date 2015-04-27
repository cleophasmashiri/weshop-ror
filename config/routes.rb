Rails.application.routes.draw do

  resources :transactions, only: [:new, :create]

  devise_for :users
  resources :products
  
  root 'products#index'
  resource :shopping_cart
end
