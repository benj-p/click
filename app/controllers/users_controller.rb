class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :takedeck, :decksummary, :deck_results]

  def dashboard
    authorize @user
    @sections = @user.sections
    @curriculums = @sections.each_with_object([]) do |section, array|
      array << section.curriculum
    end
    @decks = @curriculums.map(&:decks).flatten
    @outstanding_decks = @decks.select { |deck| deck.attempts.where(user: @user).length != deck.cards.count }
    @completed_decks = @decks.select { |deck| deck.attempts.where(user: @user).length == deck.cards.count }
  end

  def takedeck
    authorize @user
    @deck = Deck.find(params[:deck])
    @attempt = Attempt.new
  end

  def decksummary
    authorize @user
    @deck = Deck.find(params[:deck])
    @correct_answers = @deck.attempts.where(user: current_user, response: "Correct")
    @wrong_answers = @deck.attempts.where(user: current_user, response: "Incorrect")
    @unsure_answers = @deck.attempts.where(user: current_user, response: "I don't know")
  end

  def deck_results
    @deck = Deck.find(params[:deck_id])
    @teacher = @deck.curriculum.user
    authorize @teacher
    @attempts = Deck.find(params[:deck_id]).curriculum.sections.where(id: params[:section_id]).first.users.where(id: params[:id]).first.attempts
    @student = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
