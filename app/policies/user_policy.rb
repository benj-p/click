class UserPolicy < ApplicationPolicy
  def dashboard?
    @record == @user
  end
end
