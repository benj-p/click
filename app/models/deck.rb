class Deck < ApplicationRecord
  has_many :cards
  has_many :attempts, through: :cards
  belongs_to :curriculum

  validates :name, presence: true

  def deck_results(section)
    attempts = deck_attempts(self, section)
    total = attempts.count.to_f
    {
      correct: (attempts.count { |attempt| attempt.response == "Correct" } / total) * 100,
      incorrect: (attempts.count { |attempt| attempt.response == "Incorrect" } / total) * 100,
      unsure: (attempts.count { |attempt| attempt.response == "I don't know" } / total) * 100
    }
  end

  private

  def deck_attempts(deck, section)
    attempts = []
    deck.curriculum.sections.where(id: section.id).first.users.each do |user|
      user.attempts.each { |attempt| attempts << attempt if attempt.card.deck == deck }
    end
    attempts
  end
end
