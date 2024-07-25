Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  unauthenticated do
    resources :users, only: [:index]
  end
  root "users#index"
  resources :users, only: [:index, :edit, :update, :show] do
    put '/payall', to: 'users#payall'
  end
  resources :categories, only: [:index, :new, :create] do
    resources :payments, only: [:index, :new, :create] do
      put '/pay', to: 'payments#pay' 
    end
  end
end
