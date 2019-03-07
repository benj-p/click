class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
