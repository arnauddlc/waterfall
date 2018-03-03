Rails.application.routes.draw do
  devise_for :users

	authenticated do
	  root to: 'charts#index'
	end

	root to: 'pages#home'

  resources :charts, except: [:new, :show] do
    resources :datasets, only: :create
  end

  resources :datasets, only: [:update, :destroy]
end
