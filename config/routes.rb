Rails.application.routes.draw do
  resources :timelines do
    resources :categories, shallow: true
  end

  root to: 'pages#index'
end
