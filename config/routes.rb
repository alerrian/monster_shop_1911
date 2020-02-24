Rails.application.routes.draw do

	# Welcome Page
  get '/', to: 'welcome#show'
  get '/welcome', to: 'welcome#show'

	# User Session
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

	# Merchants
  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

	# Items
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  delete '/items/:id', to: 'items#destroy'

	# Reviews
  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

	# Cart
  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
	patch '/cart/:item_id/:increment_decrement', to: 'cart#increment_decrement'

	# Orders
  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  get '/orders/:id', to: 'orders#show'

	# Registration
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

	# User
  namespace :user do
    get '/profile/edit', to: 'profile#edit'
    patch '/profile', to: 'profile#update'
    get '/profile/edit_password', to: 'profile#edit_password'
    get '/profile', to: 'profile#show'
    get '/profile/orders', to: 'profile/orders#index'
    get '/profile/orders/:id', to: 'profile/orders#show'
    patch '/profile/orders/:id/cancel', to: 'profile/orders#cancel'
  end

	# Merchant Employee
  namespace :merchant_employee do
    get '/dashboard', to: 'dashboard#show'
  end

	# Admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    get '/merchants', to: 'merchants#index'
    get '/merchants/:merchant_id', to: 'merchants#show'
    patch '/users/:id/orders/:id/ship', to: 'orders#ship'
    patch '/merchants/:id', to: 'merchants#update'
  end
end
