Rails.application.routes.draw do
  get 'controller_name/new_projects'
  resources :posts
  get 'static_pages/home'
  get 'static_pages/help'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end

