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

  def feed?
    user
  end

  def deck_results?
    @record == @user
  end
end
