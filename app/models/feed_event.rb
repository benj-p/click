class FeedEvent < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  belongs_to :event_type
end
