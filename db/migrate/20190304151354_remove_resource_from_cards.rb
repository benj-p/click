class RemoveResourceFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cards, :resource, index: true
  end
end
