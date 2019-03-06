class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :takedeck]

  def dashboard
    authorize @user
    @sections = @user.sections
    @curriculums = @sections.each_with_object([]) do |section, array|
      array << section.curriculum
    end
    @decks = @curriculums.map(&:decks).flatten
    @outstanding_decks = @decks.select { |deck| deck.attempts.where(user: @user).length != deck.cards.count }
    @completed_decks = @decks.select { |deck| deck.attempts.where(user: @user).length == deck.cards.count }
    # raise
  end

  def takedeck
    authorize @user
    @deck = Deck.find(params[:deck])
    @attempt = Attempt.new
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
