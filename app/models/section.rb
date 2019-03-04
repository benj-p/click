class Section < ApplicationRecord
  belongs_to :curriculum
  has_many :registrations
  has_many :users, through: :registrations

  validates :name, presence: true
end
