class CurriculumsController < ApplicationController
  before_action :set_curriculum, only: [:show]

  def index
    @curriculums = policy_scope(Curriculum)
  end

  def show
    authorize @curriculum
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end
end
