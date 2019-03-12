class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show]

  def index
    @curriculums = policy_scope(Curriculum)
    # @attempts = Section.find(98).users.includes(:attempts).map(&:attempts).flatten
    # @correct_attempts = @attempts.select { |attempt| attempt.response == "Correct" }.count
    # @incorrect_attempts = @attempts.select { |attempt| attempt.response == "Incorrect" }.count
    # @unsure_attempts = @attempts.select { |attempt| attempt.response == "I don't know" }.count
    # raise
  end

  def show
    authorize @curriculum
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end
end
