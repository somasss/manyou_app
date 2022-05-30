Rails.application.routes.draw do
  resources :labels
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'sessions/new'
  get '/', to: 'tasks#index'
  resources :tasks, only: [:new, :create, :index, :edit, :show, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  namespace :admin do
  resources :users
  end
end