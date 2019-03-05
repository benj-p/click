class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit]

  def index
    @decks = policy_scope(Deck).joins(:curriculum).where("decks.curriculum_id = #{params[:curriculum_id]}")
  end

  def show
    authorize @deck
  end

  def new
  end

  def create
  end

  def edit
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end
end
