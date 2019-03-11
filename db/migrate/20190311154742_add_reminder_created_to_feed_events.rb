class AddReminderCreatedToFeedEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :feed_events, :reminder_created, :boolean, default: false
  end
end
