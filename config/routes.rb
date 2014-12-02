Rails.application.routes.draw do
  resources :timelines do
    collection do
      get :public
    end

    resources :categories, shallow: true
    resources :eras, shallow: true
    resources :events, shallow: true
  end

  resources :timeline_json_importers, only: [:new, :create]

  resource :session, only: [ :new, :destroy ]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  root to: 'pages#index'
end
