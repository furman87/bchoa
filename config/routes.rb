Rails.application.routes.draw do
  root 'articles#welcome'
  
  namespace :admin do
    resources :residences
    resources :residence_users
    resources :users
    resources :block_captains
    resources :board_members
    resources :mail_groups do
      collection do
        put 'add_members'
        put 'remove_members'
      end
    end
    get 'users/password/:id', to: 'users#password', as: 'user_password'
    get 'mail/new', to: 'mail_messages#new', as: 'new_mail'
    post 'mail/create', to: 'mail_messages#create', as: 'create_mail'
  end

  get 'board', to: 'board_members#index', as: 'board'
  get 'block_captains', to: 'block_captains#index', as: 'block_captains'
  get 'residents', to: 'residents#index', as: 'residents'
  get 'rules', to: 'articles#rules', as: 'rules'
  get 'documents', to: 'articles#documents', as: 'documents'
  get 'news', to: 'articles#news', as: 'news'
  get 'architectural', to: 'articles#acc', as: 'acc'
  get 'minutes', to: 'articles#minutes', as: 'minutes'
  get 'newsletters', to: 'articles#newsletters', as: 'newsletters'
  # resources :mail_messages, path: :mail #, only: [:new, :create]
  resources :articles, except: [:index, :show]
  resources :board_members
  # devise_for :users
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
end
