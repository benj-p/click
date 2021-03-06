class DeckPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:curriculum).where(curriculums: { user_id: user.id })
    end
  end

  def new?
    @record.curriculum.user = @user
  end

  def create?
    @record.curriculum.user = @user
  end

  def show?
    @record.curriculum.user = @user
  end

  def update?
    @record.curriculum.user = @user
  end
end
