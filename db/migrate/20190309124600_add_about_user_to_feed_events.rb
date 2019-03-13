class AddAboutUserToFeedEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :feed_events, :about_user_id, :bigint
    add_foreign_key :feed_events, :users, column: :about_user_id
  end
end
