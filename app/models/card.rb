class Card < ApplicationRecord
  has_many :attempts
  belongs_to :deck
end
