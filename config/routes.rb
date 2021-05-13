Rails.application.routes.draw do
  resources :listings
  devise_for :users
  root to: "welcome#index"
  get "/profile", to: "profile#index", as: "profile"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/profile", to: "profile#update"
end
