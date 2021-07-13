Rails.application.routes.draw do
  #get '/index', to: 'items#index'
  root to: "items#index"
  resources :items do # Стандартные маршруты RESTful
    # Для данных маршрутов есть acrtion_controllers: upvote и expensiv
    get :upvote, on: :member # запись дополнительного маршрута для единственного члена, участника, вида: /photos/:id/preview
    get :expensive, on: :collection # создаем дополнительный маршрут для коллекции элементов, маршрут вида: /items/expensive     
  end
end
