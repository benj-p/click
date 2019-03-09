class UserPolicy < ApplicationPolicy

  def show?
    record == user
  end

  def dashboard?
    @record == @user && @user.is_teacher == false
  end

  def takedeck?
    @record == @user && @user.is_teacher == false
  end

  def decksummary?
    @record == @user && @user.is_teacher == false
  end
end
