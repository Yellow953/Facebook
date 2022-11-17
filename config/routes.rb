Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts
  end

  get "/profile", to: "application#profile", as: "profile"

  root "application#index"
end
