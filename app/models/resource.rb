class Resource < ApplicationRecord
  attr_accessor :card
  attr_accessor :custom_field
  has_many :cards
  validates :name, presence: true

end
