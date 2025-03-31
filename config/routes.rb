Rails.application.routes.draw do
  devise_for :accounts
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "public#index"
  resources :communities
end
