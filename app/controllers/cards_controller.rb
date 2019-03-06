class CardsController < ApplicationController
  before_action :set_card, only: [:edit]

  def new
    @card = Card.new
    @card.deck = Deck.find(params[:deck_id])
    authorize @card
    @deck = @card.deck
    @curriculum = @deck.curriculum
  end

  def create
    @card = Card.new(card_params)
    @card.deck = Deck.find(params[:deck_id])
    @deck = @card.deck
    @curriculum = @deck.curriculum
    authorize @card
    if @card.save
      redirect_to curriculum_path(@curriculum)
    else
      render :new
    end
  end

  def edit
    authorize @card
    @deck = @card.deck
    @curriculum = @deck.curriculum
  end

  def update
    @card = Card.update(params[:id], card_params)
    authorize @card
    @deck = @card.deck
    @curriculum = @deck.curriculum
    if @card.save
      redirect_to curriculum_path(@curriculum)
    else
      render :edit
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:name, :question, :correct_answer, :wrong_answer, :resource_id)
  end
end
