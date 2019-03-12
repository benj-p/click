class Card < ApplicationRecord
  attr_accessor :new_resource
  has_many :attempts
  belongs_to :deck
  belongs_to :resource, optional: true
  validates :question, :correct_answer, :wrong_answer, presence: true
end
