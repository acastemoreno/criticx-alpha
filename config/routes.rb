Rails.application.routes.draw do
  # Routes for users
  resources :users, only: [:new, :create]

  # Routes for sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'session', to: 'sessions#destroy'
end
