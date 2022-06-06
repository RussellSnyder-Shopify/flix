Rails.application.routes.draw do
  resources :favorites
  resources :likes
  root 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews
  end

  resource :session, only: %i[new create destroy].freeze

  resources :users

  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
end
