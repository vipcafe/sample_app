Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "controller_name/new_projects"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "static_pages/help"
    resources :users
    resources :posts
    resources :microposts
  end
end
