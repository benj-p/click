class CreateTodoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_items do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
