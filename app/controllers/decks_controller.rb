class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit]
    skip_before_action :authenticate_user!, only: [:edit]

  def index
    @decks = policy_scope(Deck).joins(:curriculum).where("decks.curriculum_id = #{params[:curriculum_id]}")
  end

  def show
    authorize @deck
  end

  def new
    @deck = Deck.new
    @deck.curriculum = Curriculum.find(params[:curriculum_id])
    @curriculum = @deck.curriculum
    authorize @deck
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.curriculum = Curriculum.find(params[:curriculum_id])
    @curriculum = @deck.curriculum
    if @deck.save
      authorize @deck
      redirect_to curriculum_path(@curriculum)
    else
      render :new
    end
  end

  def edit
    authorize @deck
    @curriculum = @deck.curriculum
  end

  def update
    @deck = Deck.update(params[:id], deck_params)
    authorize @deck
    @curriculum = @deck.curriculum
    if @deck.save
      redirect_to curriculum_path(@curriculum)
    else
      render :edit
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end

end
