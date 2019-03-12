class Card < ApplicationRecord
  attr_accessor :new_resource
  has_many :attempts
  belongs_to :deck
  belongs_to :resource, optional: true
  validates :question, :correct_answer, :wrong_answer, presence: true

  attr_accessor :resource_name, :resource_url, :resource_text
end
