Rails.application.routes.draw do
  resources :genres
  root 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :movies do
    resources :favorites
    resources :reviews
  end

  resource :session, only: %i[new create destroy].freeze

  resources :users
  resources :genres

  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
end
