class Deck < ApplicationRecord
  has_many :cards
  has_many :attempts, through: :cards
  belongs_to :curriculum

  validates :name, presence: true

  def deck_results(section)
    attempts = []
    self.curriculum.sections.where(id: section.id).first.users.each do |user|
      user.attempts.each { |attempt| attempts << attempt }
    end
    attempts
  end
end
