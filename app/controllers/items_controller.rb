class ItemsController < ApplicationController
  #layout false
  skip_before_action :verify_authenticity_token

  def index
    @items = Item.all
    #render body: @items.map {|item| "#{item.name}, #{item.price}, #{item.description}"}    
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.create(item_params)
    if item.persisted? # если item сохранен
      redirect_to items_path
      #render json: item.name, status: :created
      #render json: "Данные сохранены" # рендер в формате json
    else # если item не прошел валидацию и не сохранился
      render json: item.errors # рендер в формате json ошибки items
    end    
  end

  def show
    # Rails переходит на метод show, после того, как перехватывает из браузера маршрут вида /items/:id где :id - номер записи в базе данных, и сохраняет этот id в хеше params для дальнейшего использования
    @item = Item.find(params[:id]) # Поиск записи в базе данных по id, переданного в хеше params. Сохраняет в переменной экземпляра массив с хешем данных найденного объекта        
  end

  def edit
  end

  def update
  end

  def destroy    
    Item.find(params[:id]).destroy    
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :description)
    #params.permit(:name, :price, :weight, :description)
  end
end
