class UserPolicy < ApplicationPolicy
  def dashboard?
    @record == @user && @user.is_teacher == false
  end

  def takedeck?
    @record == @user
  end

  def decksummary?
    @record == @user
  end
end
