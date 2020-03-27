Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweeets
  resources :users, only: [:show]

  authenticated :user do
    root "tweeets#index" , as: :authenticated_root
  end

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
end