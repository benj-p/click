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
  end

  def create
  end

  def edit
    authorize @deck
  end

  def update
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end
end
