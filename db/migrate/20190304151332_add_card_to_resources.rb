class AddCardToResources < ActiveRecord::Migration[5.2]
  def change
    add_reference :resources, :card, foreign_key: true
  end
end
