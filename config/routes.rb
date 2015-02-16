Bookmarks::Application.routes.draw do
  get "site/index"
  devise_for :users
  resources :bookmarks
  root 'site#index'
end
