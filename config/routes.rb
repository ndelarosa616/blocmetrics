Rails.application.routes.draw do
  resources :registered_applications

  devise_for :users

  get 'about' => 'welcome#about'

  authenticated :user do
    root to: 'registered_applications#index', as: :authenticated_root, via: :get
  end

  unauthenticated do
    root to: 'welcome#index'
  end

  namespace :api, defaults: { format: :json } do
    match 'create_event', to: 'events#create', via: [:options]
    resources :events, only: [:create]
  end

end