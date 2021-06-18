Rails.application.routes.draw do
  devise_for :admins, only: %i[sessions passwords]
  devise_for :users
  root to: 'events#index'
  resources :events
  namespace :admin do
    root to: 'events#index'
    resources :events, except: %i[new create]
  end
end
