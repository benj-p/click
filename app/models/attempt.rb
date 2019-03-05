class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :card
  has_one :deck, through: :cards
end
