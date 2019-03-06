class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit]
    skip_before_action :authenticate_user!, only: [:edit]

  def index
    @decks = policy_scope(Deck).joins(:curriculum).where("decks.curriculum_id = #{params[:curriculum_id]}")
  end

  def show
    @section = Section.find(params[:section_id])
    @results_by_student = []
    @results_by_card = {}
    @results = { correct: 0, incorrect: 0, unsure: 0 }
    attempts = @section.users.map { |user| user.attempts.select { |attempt| attempt.card.deck == @deck } }
    @attempts_count = attempts.count

    @deck.cards.each do |card|
      @results_by_card[card.id] = {card: card, results: { correct: 0, incorrect: 0, unsure: 0 } }
    end

    @section.users.each do |student|
      results = { correct: 0, incorrect: 0, unsure: 0 }
      student.attempts.each do |attempt|
        if attempt.card.deck == @deck
          case attempt.response
          when "Correct" then results[:correct] += 1
          when "Incorrect" then results[:incorrect] += 1
          when "I don't know" then results[:unsure] += 1
          end
        end
      end
      @results_by_student << { student: student, results: results }
    end

    attempts.each do |collection|
      collection.each do |attempt|
        case attempt.response
        when "Correct"
          @results[:correct] += 1
          @results_by_card[attempt.card.id][:results][:correct] += 1
        when "Incorrect"
          @results[:incorrect] += 1
          @results_by_card[attempt.card.id][:results][:incorrect] += 1
        when "I don't know"
          @results[:unsure] += 1
          @results_by_card[attempt.card.id][:results][:unsure] += 1
        end
      end
    end
    # raise
    authorize @deck
  end

  def new
    @deck = Deck.new
    @deck.curriculum = Curriculum.find(params[:curriculum_id])
    @curriculum = @deck.curriculum
    authorize @deck
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.curriculum = Curriculum.find(params[:curriculum_id])
    @curriculum = @deck.curriculum
    if @deck.save
      authorize @deck
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      render :new
    end
  end

  def edit
    authorize @deck
    @curriculum = @deck.curriculum
  end

  def update
    @deck = Deck.update(params[:id], deck_params)
    authorize @deck
    @curriculum = @deck.curriculum
    if @deck.save
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      render :edit
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end

end
