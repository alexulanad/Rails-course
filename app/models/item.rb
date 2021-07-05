class Item < ApplicationRecord
  validates :price, numericality: { greater_than: -1 }
  validates :name, :description, presence: true

  after_initialize  {p 'Инициализация'} # Item.new, Item.first, Item.last
  after_save        {p 'Сохранено'}     # Item.save, Item.create
  after_create      {p 'Создано'}       # Item.create
  after_update      {p 'Обновлено'}     # Item.update
  after_destroy    {p 'Удалено'}       # Item.last.destroy
end
