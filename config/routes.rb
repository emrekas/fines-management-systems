Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  #get "/" => "home#index", as: :home
  get "/", to: "home#index", as: :home
  get "/users" => "users#index", as: :users
  get "/users/login" => "users#login", as: :login
  post "/users/login" => "users#login_attempt", as: :login_attempt
  get "/users/logout" => "users#logout", as: :logout
  get "/users/register" => "users#register", as: :register
  post "/users/register" => "users#create", as: :create_user

  resources :vehicles
  resources :fines
  resources :users
end
