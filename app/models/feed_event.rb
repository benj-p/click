class FeedEvent < ApplicationRecord
  belongs_to :user
  belongs_to :deck, optional: true
  belongs_to :event_type

end
