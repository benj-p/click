class Curriculum < ApplicationRecord
  has_many :decks
  has_many :sections
  belongs_to :user

  validates :name, presence: true
end
