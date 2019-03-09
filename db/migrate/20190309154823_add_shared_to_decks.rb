class AddSharedToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :shared, :boolean, default: false
  end
end
