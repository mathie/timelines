Rails.application.routes.draw do
  resources :timelines

  root to: 'pages#index'
end
