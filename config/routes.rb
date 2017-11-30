Rails.application.routes.draw do
  devise_for :users

  resources :teams do
    resources :standups, only: [:index, :create]
    resources :team_invites, only: [:index, :show, :create, :update, :destroy]
  end

  authenticated do
    root :to => 'teams#index', as: :authenticated
  end

  root to: 'pages#show', id: 'home'
end
