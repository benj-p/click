class AddReferencesToSections < ActiveRecord::Migration[5.2]
  def change
    add_reference :sections, :curriculum, foreign_key: true
  end
end
