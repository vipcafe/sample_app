Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :users, except: %i(new)
    resources :microposts
     get "sessions/new"
  get "users/show"
  get "controller_name/new_projects"
  resources :posts
  root to: "static_pages#home"
  get "static_pages/help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
# resources :users
end
end

