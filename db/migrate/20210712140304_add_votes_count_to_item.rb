class AddVotesCountToItem < ActiveRecord::Migration[6.1]
  def change
    # добавить колонку в таблицу items с именем votes_count и типом integer с значением 0 по умолчанию.
    add_column :items, :votes_count, :integer, default: 0
  end
end
