Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'dashboards#index'

  namespace :admin do
    resources :users, except: [:new, :create] do
      post :lock, on: :member
      post :unlock, on: :member
    end
  end
end
