Rails.application.routes.draw do
  resources :listings
  devise_for :users
  root to: "welcome#index"
  get "/profile", to: "profile#index", as: "profile"
  post "/profile", to: "profile#become_grandma"
  get "/listings/view/:id", to: "listings#show_users", as: "listings_show_users"

  #Mailbox routes
  resources :conversations do
    resources :messages
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
