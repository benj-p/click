class Deck < ApplicationRecord
  has_many :cards
  has_many :attempts, through: :cards
  belongs_to :curriculum

  validates :name, presence: true
end
