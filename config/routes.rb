Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  unauthenticated do
    resources :users, only: [:index]
  end
  root "users#index"
  resources :users, only: [:index]
  resources :categories do
    resources :payments
  end
end
