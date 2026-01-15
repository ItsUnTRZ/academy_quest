Rails.application.routes.draw do
  resources :quests
  get "up" => "rails/health#show", as: :rails_health_check
  get "/brag" => "brag#index", as: :brag
  root "quests#index"
end
