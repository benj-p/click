class Card < ApplicationRecord
  has_many :attempts
  belongs_to :deck
  belongs_to :resource, optional: true
  validates :question, :correct_answer, :wrong_answer, presence: true
end
