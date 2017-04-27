Rails.application.routes.draw do
  devise_for :users
  resources :teams

  authenticated do
    root :to => 'teams#index', as: :authenticated
  end

  get '/' => 'high_voltage/pages#show', id: 'home'
end
