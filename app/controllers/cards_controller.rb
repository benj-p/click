class CardsController < ApplicationController
  before_action :set_card, only: [:edit]
  before_action :deck_resources, only: [:index, :new, :edit]

  def index
    @cards = policy_scope(Card).where(deck: Deck.find(params[:deck_id]))
    @deck = Deck.find(params[:deck_id])
    @curriculum = Curriculum.find(params[:curriculum_id])
  end

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
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
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
    @card = Card.find(params[:id])
    @card.update(card_params)
    @resource = Resource.find(params[:card][:resource])
    @card.resource = @resource
    @card.save
    authorize @card
    @deck = @card.deck
    @curriculum = @deck.curriculum
    if @card.save
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      render :edit
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:name, :question, :correct_answer, :wrong_answer)
  end

  def deck_resources
    resources = []
    Deck.find(params[:deck_id]).cards.each do |card|
      if card.resource
        resources << card.resource
      end
    end
    @resources = resources.uniq
  end
end
