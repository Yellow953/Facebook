Rails.application.routes.draw do
  resources :likes
  resources :friend_requests
  resources :comments
  resources :posts
  devise_for :users

  get "/profile", to: "application#profile", as: "profile"
  post "/profile", to: "application#edit_user", as: "edit_user"
  
  get "/post/:id/comments", to:"application#comments", as: "post_comments"
  post "/post/:id/comments", to: "application#create_comment", as: "create_post_comment"

  get "/user/:id/addfriend", to: "application#add_friend", as: "add_friend"
  get "/user/:id/requests", to: "application#user_requests", as:"user_requests"
  get "/users", to:"application#users", as:"get_users"

  get "/request/:id/accept", to: "application#accept", as:"accept"


  root "application#index"
end
