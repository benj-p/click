class ResourcesController < ApplicationController
  def new
    @resource = Resource.new
    @deck = Deck.find(params[:deck_id])
    @curriculum = @deck.curriculum
    authorize @deck
  end

  def create
    @resource = Resource.new(resource_params)
    @deck = Deck.find(params[:deck_id])
    @curriculum = @deck.curriculum
    authorize @deck
    if @resource.save
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      render :new
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update

  end

  private

  def resource_params
    params.require(:resource).permit(:name, :text, :url)
  end
end
