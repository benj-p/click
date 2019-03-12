class CardsController < ApplicationController
  before_action :set_card, only: [:edit]
  before_action :deck_resources, only: [:index, :new, :edit]

  def index
    @cards = policy_scope(Card).where(deck: Deck.find(params[:deck_id]))
    @deck = Deck.find(params[:deck_id])
    @curriculum = Curriculum.find(params[:curriculum_id])
    @card = Card.new
    @resource = Resource.new
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
    if !params[:card][:resource].empty?
      @card.resource = Resource.find(params[:card][:resource])
    elsif params[:card][:resource_name] && params[:card][:resource_text] && params[:card][:resource_url]
      resource = Resource.new(name: params[:card][:resource_name], text: params[:card][:resource_text], url: params[:card][:resource_url] )
      if resource.save
        @card.resource = resource
      end
    end
    authorize @card
    if @card.save
      flash[:notice] = "Card created"
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
    else
      flash[:notice] = "Card not created"
      redirect_to curriculum_deck_cards_path(@curriculum, @deck)
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
    if Resource.find(params[:card][:resource])
      @resource = Resource.find(params[:card][:resource])
    end
    @card.resource = @resource
    raise
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
    params.require(:card).permit(:name, :question, :correct_answer, :wrong_answer, resource_attributes: [:name, :url, :text])
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
