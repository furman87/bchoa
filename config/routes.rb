Rails.application.routes.draw do
  get 'articles/rules', to: 'articles#rules', as: 'rules'
  resources :articles
  devise_for :users
  root 'welcome#index'
end
