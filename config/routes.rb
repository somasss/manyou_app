Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  resources :tasks, only: [:new, :create, :index, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
