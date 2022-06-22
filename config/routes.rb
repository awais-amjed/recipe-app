Rails.application.routes.draw do
  resources :foods
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :recipes, only: [:index, :show, :new, :create, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :public_recipes, only: [:index]
  root "recipes#index"
end
