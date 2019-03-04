class Resource < ApplicationRecord
  belongs_to :card
  validates :name, :type, presence: true
end
