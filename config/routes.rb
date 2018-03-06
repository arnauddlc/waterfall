Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

	authenticated do
	  root to: 'charts#index'
	end

	root to: 'pages#home'

  get '/waterfallplayground', to: "charts#waterfallplayground"

  resources :charts, except: [:new, :show] do
    resources :datasets, only: [:create, :update]
  end

  edit '/charts/:id/wf', to: "charts#editwaterfall", as: :edit_waterfall

  resources :datasets, only: [:edit, :destroy]
end
