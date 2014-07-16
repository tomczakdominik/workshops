Rails.application.routes.draw do
  resources :categories do
    get 'categories/:category_id/products(.:format)', :to => 'products#index', :as => 'products'
    resources :products do
      resources :reviews
    end
  end
  devise_for :users
  root 'categories#index'
  # root 'base#index'



  # PATCH 'categories/:category_id/products/:id(.:format)', to: 'products#update'

# get 'categories/:category_id/products/:id(.:format)', :to => 'products#update', via: [:patch]
# match 'categories/:category_id/products/:id(.:format)', :to => 'products#update', via: [:patch]
# match 'categories/:category_id/products/:id(.:format)', :to => 'new_user_session_path', via: [:put]
# match 'photos', to: 'products#update', via: [:get, :post]
# , :except => [:update]




end