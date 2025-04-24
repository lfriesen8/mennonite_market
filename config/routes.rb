Rails.application.routes.draw do
  # Home and category routes
  root 'home#index'
  get 'home/index'

  # Pages route (existing and updated for about and contact)
  get '/pages/:slug', to: 'pages#show', as: :page
  get '/about', to: 'pages#show', slug: 'about', as: :about
  get '/contact', to: 'pages#show', slug: 'contact', as: :contact

  # Orders
  resources :orders, only: [:new, :create, :show]
  get '/my_orders', to: 'orders#history', as: :order_history

  # Stripe payment routes
  post '/create-checkout-session', to: 'payments#create_checkout_session', as: :create_checkout_session
  get '/checkout/success', to: 'payments#success', as: :checkout_success
  get '/checkout/cancel', to: 'payments#cancel', as: :checkout_cancel

  # Edit profile
  get 'profile', to: 'users#edit_profile'
  patch 'profile', to: 'users#update_profile'

  # Cart
  post 'add_to_cart', to: 'home#add_to_cart', as: :add_to_cart
  get 'cart', to: 'home#view_cart', as: :view_cart
  patch 'update_cart', to: 'home#update_cart', as: :update_cart
  delete 'remove_from_cart', to: 'home#remove_from_cart', as: :remove_from_cart

  # Product and category routes
  resources :products, only: [:show]
  resources :categories, only: [:show]

  # Devise and ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  post '/webhooks/stripe', to: 'stripe_webhooks#receive'

  # Health check and PWA
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
end

