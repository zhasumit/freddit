Rails.application.routes.draw do
  devise_for :accounts
  get "up" => "rails/health#show", as: :rails_health_check
  get "u/:username" => "public#profile", as: :profile

  resources :communities do
    resources :posts
  end
  root to: "public#index"
end
