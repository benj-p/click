class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.deck.curriculum.user == @user
  end

  def update?
    record.deck.curriculum.user == @user
  end
end
