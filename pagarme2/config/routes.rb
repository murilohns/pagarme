Rails.application.routes.draw do
  
  resources :addresses
  resources :transactions
  get 'transaction/new'

  resources :recipients
  get 'home/index'
  root 'cards#index'
  
  resources :cards
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
