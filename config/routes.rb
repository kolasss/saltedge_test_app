Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'

  resources :connections, only: %i[index show new create destroy] do
    member do
      put :refresh
      put :reconnect
      put :fetch
    end
    collection do
      put :refresh_all
    end
  end
  resources :accounts, only: [:show]

  get 'oauth_providers/authorize'
end
