class TodoItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    user
  end

  def mark_complete?
    record.user == user
  end
end
