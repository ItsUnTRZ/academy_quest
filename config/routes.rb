Rails.application.routes.draw do
  resources :quests
  get "up" => "rails/health#show", as: :rails_health_check
  get "/brag" => "brag#index", as: :brag
  get "/brag/*path", to: redirect("/brag")
  get "*path", to: redirect("/")
  root "quests#index"
end
