class FeedEvent < ApplicationRecord
  belongs_to :user
  belongs_to :about_user, :class_name => 'User', :foreign_key => 'about_user_id'


  belongs_to :deck, optional: true
  belongs_to :event_type

end
