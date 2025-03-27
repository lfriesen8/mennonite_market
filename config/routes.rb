Rails.application.routes.draw do
  # Home and category routes
  root 'home#index'  # Setting the root route to the home page
  get 'home/index'

  # Pages route (existing)
  get 'pages/show'
  get '/pages/:slug', to: 'pages#show', as: :page

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
