Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/about',    to: 'static_pages#about'
  get  '/signup',   to: 'users#new'
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/guest', to: 'guest_sessions#create'
  resources :users do
    member do
      get :following, :followers, :reviews, :favorites, :microposts
    end
  end
  resources :supplements do
    resource :favorites, only: [:create, :destroy]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :reviews,             only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end