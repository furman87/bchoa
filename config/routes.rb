Rails.application.routes.draw do
  root 'articles#welcome'
  get 'board', to: 'board_members#index', as: 'board'
  get 'block_captains', to: 'block_captains#index', as: 'block_captains'
  get 'residents', to: 'residents#index', as: 'residents'
  get 'rules', to: 'articles#rules', as: 'rules'
  get 'documents', to: 'articles#documents', as: 'documents'
  get 'news', to: 'articles#news', as: 'news'
  get 'architectural', to: 'articles#acc', as: 'acc'
  resources :articles
  resources :board_members
  devise_for :users
end
