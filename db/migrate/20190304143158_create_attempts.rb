class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.references :user, foreign_key: true
      t.string :response

      t.timestamps
    end
  end
end
