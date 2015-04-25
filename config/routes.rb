Rails.application.routes.draw do
  devise_for :users
  resources :products
  
  root 'products#index'
  resource :shopping_cart
end
