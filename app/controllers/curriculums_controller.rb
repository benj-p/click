class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show]

  def show
    authorize @curriculum
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end
end
