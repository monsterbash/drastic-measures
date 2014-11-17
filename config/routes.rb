Rails.application.routes.draw do
  
  resources :sessions
  resources :accounts

  resources :users 
  resources :records
  resources :search


  get "/search" => "home#search"
  get "/posts" => "home#show", as: :posts
  get '/' => "home#index", as: :home_page


  get "/signin" => "sessions#new", as: :signin
  # post "/signin" =>  "sessions#create"
  get "/signout" => "sessions#destroy"
  post "/search/ig_search" => "search#do_search"
  get "/search/list_users" => "search#list"
  post "/search/unfollow" => "search#do_unfollow"


  get '/auth/:provider/callback', to: 'sessions#create'

end