class FeedEvent < ApplicationRecord
  belongs_to :user
  belongs_to :about_user, :class_name => 'User', :foreign_key => 'about_user_id', optional: true
  belongs_to :section, optional: true


  belongs_to :deck, optional: true
  belongs_to :event_type
  self.per_page = 10

end
