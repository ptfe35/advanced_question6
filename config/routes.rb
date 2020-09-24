Rails.application.routes.draw do
  devise_for :users
  root :to => 'home#top'
  get 'home/about' => 'home#about'
  resources :users, only: [:index, :show, :create, :edit, :update]
  resources :relationships, only: [:index, :create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get 'search' => 'search#search'
end
