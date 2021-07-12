Rails.application.routes.draw do
  #get '/index', to: 'items#index'
  root to: "items#index"
  resources :items do # Стандартные маршруты RESTful
    get :upvote, on: :member # запись дополнительного маршрута для единственного члена, участника, вида: '/photos/:id/preview'
  end
end
