Rails.application.routes.draw do
  use_doorkeeper
  mount Linkus::API => '/api'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'users#index'
  resources :users

  namespace :admin do
    resources :users, except: [:new, :create] do
      post :lock, on: :member
      post :unlock, on: :member
    end
  end
end
