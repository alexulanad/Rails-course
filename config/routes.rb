Rails.application.routes.draw do
  get '/index', to: 'items#index'

  resources :items
end
