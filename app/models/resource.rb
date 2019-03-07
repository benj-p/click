class Resource < ApplicationRecord
  attr_accessor :card
  has_many :cards
  validates :name, presence: true
end
