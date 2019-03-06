class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :card
  has_one :deck, through: :cards

  validates :user_id, uniqueness: { scope: [:card_id] }
end
