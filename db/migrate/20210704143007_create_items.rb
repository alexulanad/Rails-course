class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name # столбец name (имя) с типом string
      t.float :price # столбец price (цена) с типом float
      t.float :weight # столбец weight (вес) с типом float
      t.boolean :real # столбец real (реальный) с типом boolean = true или false
      t.string :description # столбец description (описание) c типом string
      t.timestamps
    end

    add_index :items, :price
    add_index :items, :name
  end
end
