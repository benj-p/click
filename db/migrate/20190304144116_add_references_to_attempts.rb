class AddReferencesToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_reference :attempts, :card, foreign_key: true
  end
end
