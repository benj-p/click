class SectionsController < ApplicationController
  before_action :set_section, only: :show

  def show
    authorize @section
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

end
