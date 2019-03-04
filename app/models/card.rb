class Card < ApplicationRecord
  has_many :attempts
  belongs_to :deck
  has_one :resource

  validates :question, :correct_answer, :wrong_answer, presence: true
end
