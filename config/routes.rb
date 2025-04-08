Rails.application.routes.draw do
  # Home and category routes
  root 'home#index'  # Setting the root route to the home page
  get 'home/index'

  # Pages route (existing and updated for about and contact)
  get '/pages/:slug', to: 'pages#show', as: :page
  # These are the specific routes for about and contact
  get '/about', to: 'pages#show', slug: 'about', as: :about
  get '/contact', to: 'pages#show', slug: 'contact', as: :contact

  # Route for adding products to the cart
  post 'add_to_cart', to: 'home#add_to_cart', as: :add_to_cart

  # Define the route for viewing the cart
  get 'cart', to: 'home#view_cart', as: :view_cart

  delete 'remove_from_cart', to: 'home#remove_from_cart', as: :remove_from_cart


  # Product and category routes
  resources :products, only: [:show]  # For viewing individual products
  resources :categories, only: [:show]  # For viewing products by category

  # Devise routes for users and admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Health check and PWA routes
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end

