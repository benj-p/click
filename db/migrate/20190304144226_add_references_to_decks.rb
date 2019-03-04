class AddReferencesToDecks < ActiveRecord::Migration[5.2]
  def change
    add_reference :decks, :curriculum, foreign_key: true
  end
end
