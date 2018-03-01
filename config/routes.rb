Rails.application.routes.draw do
  get 'charts/index'

  get 'charts/new'

  get 'charts/edit'

  devise_for :users
  root to: 'charts#index'

  resources :charts, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
