class CreateFeedEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_events do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.references :deck, foreign_key: true
      t.references :event_type, foreign_key: true

      t.timestamps
    end
  end
end
