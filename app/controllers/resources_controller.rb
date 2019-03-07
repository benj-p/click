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
    @deck = Deck.find(params[:deck_id])
    authorize @deck
    @curriculum = @deck.curriculum
  end

  def update
    @resource = Resource.find(params[:id])
    @deck = Deck.find(params[:deck_id])
    @resource.update(resource_params)
    authorize @deck
    @curriculum = @deck.curriculum
    if @resource.save
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      render :edit
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :text, :url)
  end
end
