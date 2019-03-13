class AddSectionToFeedEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :feed_events, :section, foreign_key: true
  end
end
