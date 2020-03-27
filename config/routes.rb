Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweeets
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tweeets#index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
end