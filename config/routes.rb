Rails.application.routes.draw do
  devise_for :accounts
  get "up" => "rails/health#show", as: :rails_health_check

  resources :communities do
    resources :posts
  end
  root to: "public#index"
end
