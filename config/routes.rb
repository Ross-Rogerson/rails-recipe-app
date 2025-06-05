require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: "meals#index"
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :meals
  
  resources :ingredients do
    collection do
      get :new_with_grocery_item
      post :create_with_grocery_item
    end
  end

  resources :grocery_items

  resources :users, only: [:index, :show] do
    member do
      post :follow
      delete :unfollow
      get :followers
      get :following
    end
    get "meals", to: "meals#user_meals", as: :meals
    # get "ingredients", to: "ingredients#user_ingredients", as: :ingredients
    # get "grocery_items", to: "grocery_items#user_grocery_items", as: :grocery_items
  end
end
