class ItemsController < ApplicationController
  layout false
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
    #redirect_to items_path
    #render json: item.name, status: :created
    if item.persisted? # если item сохранен
      render json: "Данные сохранены" # рендер в формате json
    else # если item не прошел валидацию и не сохранился
      render json: item.errors # рендер в формате json ошибки items
    end    
  end


  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :description)
    #params.permit(:name, :price, :weight, :description)
  end
end
