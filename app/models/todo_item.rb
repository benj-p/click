class TodoItem < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  def complete
    self.update(completed: true)
  end
end
