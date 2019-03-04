class Curriculum < ApplicationRecord
  has_many :decks
  belongs_to :user

  validates :name, presence: true
end
