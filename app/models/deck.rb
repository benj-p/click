class Deck < ApplicationRecord
  has_many :cards
  belongs_to :curriculum

  validates :name, presence: true
end
