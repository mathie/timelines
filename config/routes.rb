Rails.application.routes.draw do
  resources :timelines do
    resources :categories, shallow: true
    resources :eras, shallow: true
    resources :events, shallow: true
  end

  root to: 'pages#index'
end
