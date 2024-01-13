Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/vehicles", to: "vehicles#index"

end
