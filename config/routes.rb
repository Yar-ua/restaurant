Rails.application.routes.draw do
  

  mount ActionCable.server => '/cable'

  # просмотр админом оформленных заказов
  resources :single_orders, only: [:index, :show, :destroy]
  resources :group_orders_admin, only: [:index, :show, :destroy]
  resources :user_group_orders, only: [:index, :show]
  #get '/group_orders_admin/:id' to: 'group_orders_admin#show'


  root to: 'store#index'

  resources :members
  resources :joiners
  resources :groups
  resources :orders
  resources :store, only: [:index, :show]
  resources :line_items
  resources :carts

  scope '/group/:group_id' do
    resources :group_store, only: [:index, :show]
    resources :group_line_items
    resources :group_carts
    resources :group_orders
  end

  devise_for :users
  # общая точка входа
  #root to: 'product_types#index'
  get '/' => 'product_types#index'

  # в ресурсе :product_types вводим вложенный ресурс :products
  resources :product_types do
  	resources :products
  end

 
end
