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

  get '/charts/:id/edit/wf', to: "charts#edit", as: :edit_wf_chart

  resources :datasets, only: [:edit, :destroy]
end
