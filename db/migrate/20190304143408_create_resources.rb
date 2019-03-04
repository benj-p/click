class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :type
      t.text :text
      t.string :url

      t.timestamps
    end
  end
end
