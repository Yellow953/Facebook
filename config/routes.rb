Rails.application.routes.draw do
  resources :comments
  resources :posts
  devise_for :users

  get "/profile", to: "application#profile", as: "profile"

  
  get "/post/:id/comments", to:"application#comments", as: "post_comments"
  post "/post/:id/comments", to: "application#create_comment", as: "create_post_comment"

  post "/profile", to: "application#edit_user", as: "edit_user"

  root "application#index"
end
