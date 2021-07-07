class ItemsController < ApplicationController
  #layout false
  #skip_before_action :verify_authenticity_token

  def index
    @items = Item.all
    #render body: @items.map {|item| "#{item.name}, #{item.price}, #{item.description}"}    
  end

  def new
    @item = Item.new
  end

  def create
    if params[:name] == "Запись"
      item = Item.new(
        name: params[:name], 
        price: params[:price], 
        weight: params[:weight], 
        description: params[:description])
      item.save
      redirect_to items_path
    else
      item = Item.create(item_params)
      if item.persisted? # если item сохранен то
        redirect_to items_path # перееаправить на страницу всех объектов Item
      #render json: item.name, status: :created
      #render json: "Данные сохранены" # рендер в формате json
      else # если item не прошел валидацию и не сохранился
        render json: item.errors # рендер в формате json ошибки items
      end
    end    
  end

  def show
    # Rails переходит на метод show, после того, как перехватывает из браузера маршрут вида /items/:id где :id - номер записи в базе данных, и сохраняет этот id в хеше params для дальнейшего использования
    # Поиск записи в базе данных по id, переданного в хеше params. Сохраняет в переменной экземпляра массив с хешем данных найденного объекта        
    @item = Item.find(params[:id])    
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update    
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path
    else
      render json: item.errors
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy    
      redirect_to items_path
    else
      render json: item.errors
    end    
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :description)
    #params.permit(:name, :price, :weight, :description)
  end
end
