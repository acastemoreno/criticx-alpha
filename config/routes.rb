Rails.application.routes.draw do
  resources :games, only: [:index, :show]
  resources :companies, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
