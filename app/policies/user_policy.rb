class UserPolicy < ApplicationPolicy
  def dashboard?
    @record == @user
  end

  def takedeck?
    @record == @user
  end

  def decksummary?
    @record == @user
  end
end
