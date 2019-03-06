class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:deck).where(decks: { deck_id: deck.id })
    end
  end

  def create?
    record.deck.curriculum.user == @user
  end

  def update?
    record.deck.curriculum.user == @user
  end
end
