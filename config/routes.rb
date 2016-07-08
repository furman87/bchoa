Rails.application.routes.draw do
  resources :articles
  devise_for :users
  root 'welcome#index'
end
