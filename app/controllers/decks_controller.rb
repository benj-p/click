class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit]
    skip_before_action :authenticate_user!, only: [:edit]

  def index
    @decks = policy_scope(Deck).joins(:curriculum).where("decks.curriculum_id = #{params[:curriculum_id]}")
  end

  def show
    @section = Section.find(params[:section_id])
    @results_by_student = []
    @results = { correct: 0, incorrect: 0, unsure: 0 }
    attempts = @section.users.map { |user| user.attempts }

    @section.users.each do |student|
      results = { correct: 0, incorrect: 0, unsure: 0 }
      student.attempts.each do |attempt|
        case attempt.response
        when "Correct" then results[:correct] += 1
        when "Incorrect" then results[:incorrect] += 1
        when "I don't know" then results[:unsure] += 1
        end
      end
      @results_by_student << { student: student, results: results }
    end

    attempts.each do |collection|
      collection.each do |attempt|
        case attempt.response
        when "Correct" then @results[:correct] += 1
        when "Incorrect" then @results[:incorrect] += 1
        when "I don't know" then @results[:unsure] += 1
        end
      end
    end
    # raise
    authorize @deck
  end

  def new
  end

  def create
  end

  def edit
    authorize @deck
  end

  def update
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end
end
