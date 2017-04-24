Rails.application.routes.draw do
  devise_for :users
  get '/' => 'high_voltage/pages#show', id: 'home'
end
