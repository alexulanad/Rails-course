class ItemsController < ApplicationController
  def index
    @items = Item.all
    #render body: @items.map {|item| "#{item.name}, #{item.price}, #{item.description}"}    
  end
end
