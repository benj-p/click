class UserPolicy < ApplicationPolicy
  def dashboard?
    @record == @user && @user.is_teacher == false
  end

  def takedeck?
    @record == @user && @user.is_teacher == false
  end

  def decksummary?
    @record == @user && @user.is_teacher == false
  end

  def deck_results?
    true
  end
end
