class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard]

  def dashboard
    authorize @user
    @sections = @user.sections
    @curriculums = @sections.each_with_object([]) do |section, array|
      array << section.curriculum
    end
    @decks = @curriculums.each_with_object([]) do |curriculum, array|
      array << curriculum.decks
    end
    raise
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
