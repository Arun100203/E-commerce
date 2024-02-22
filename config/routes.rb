Rails.application.routes.draw do

  use_doorkeeper 
  # do
  #   skip_controllers :authorizations, :applications, :authorized_applications
  # end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :customerinfos, controllers: {registrations: 'customerinfo/registrations'}, views: {sessions: "customerinfo/sessions"}
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get "/carts", to: "carts#index"

  get "/products", to: "products#index"

  get "/transactions", to: "transactions#index"

  get "/about", to: "about#index"

  get "/faq", to: "faq#index"

  get "/selling", to: "selling#index"

  get "/profiles", to: "profiles#index"

  get "/checkout", to: "checkout#index"

  get "/checkout/:id", to: "checkout#index"

  post "/checkout/:id/buy", to: "checkout#buy", as: :buy_checkout

  get "/accounts", to: "accounts#index"

  resources :products do
    post 'add_to_cart', on: :member
    post 'likes', on: :member, to: 'likes#create'
    delete 'unlike', on: :member
    delete :delete_comment, on: :member
    member do
      post 'add_to_cart'
      get "edit"
    end
  end
  
  resources :carts, only: [:create, :show, :update, :destroy] do
    delete 'remove_from_cart', on: :member, as: 'remove_from_cart'
    delete 'buy_all', on: :member, as: 'buy_all'
  end

  resources :comments do
    delete :delete_comment, on: :member
    post 'likes', on: :member, to: 'comments#like'
    patch :update_comment, on: :member
    delete 'unlike', on: :member
  end
  
  resources :profiles do
    delete :delete_address, to: 'profiles#destroy', on: :member
  end

  resources :accounts do
    delete :delete_account, to: 'accounts#destroy', on: :member
  end

  resources :home 

  resources :likes, only: [:create, :destroy] 

  # For API calls
  namespace :api do
    namespace :v1 do
      get "/products/product_sold_count", to: "products#product_sold_count"
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resources :carts, only: [:index, :show, :create, :update, :destroy]
      resources :transactions, only: [:index, :show, :create, :update, :destroy]
      resources :types, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :customs, only: [:show, :index, :create, :update, :destroy] 
    end
  end

  match '*path', to: 'application#exception_handler', constraints: ->(req) { req.path.exclude?('/rails/active_storage') }, via: [:all]

end
