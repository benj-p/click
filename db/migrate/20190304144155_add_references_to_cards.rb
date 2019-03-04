class AddReferencesToCards < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :deck, foreign_key: true
    add_reference :cards, :resource, foreign_key: true
  end
end
