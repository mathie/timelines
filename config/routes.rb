Rails.application.routes.draw do
  resources :timelines do
    collection do
      get :public
    end

    resources :categories, shallow: true
    resources :eras, shallow: true
    resources :events, shallow: true

    resources :invitations, shallow: true, only: [:new, :create] do
      resources :collaborations, only: [:new, :create]
    end
  end

  resources :timeline_json_importers, only: [:new, :create]

  resource :session, only: [ :new, :destroy ]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  root to: 'pages#index'
end
