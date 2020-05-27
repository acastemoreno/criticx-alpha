Rails.application.routes.draw do
  resources :games, only: [:index, :show]
  resources :companies, only: [:index, :show]

  # Routes for users
  resources :users, only: [:new, :create]

  # Routes for sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'session', to: 'sessions#destroy'

end
