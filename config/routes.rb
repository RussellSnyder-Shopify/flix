Rails.application.routes.draw do
  resources :users
  root 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews
  end
end
