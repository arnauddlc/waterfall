Rails.application.routes.draw do
  devise_for :users
  root to: 'charts#index'

  resources :charts, except: :show do
    resources :datasets, only: :create
  end

  resources :datasets, only: [:update, :destroy]
end
