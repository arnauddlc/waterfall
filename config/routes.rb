Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

	authenticated do
	  root to: 'charts#index'
	end

	root to: 'pages#home'

	get "/chart_test", to: "pages#chart_test"

  resources :charts, except: [:new, :show] do
    resources :datasets, only: [:create, :update]
  end

  resources :datasets, only: [:edit, :destroy]
end
