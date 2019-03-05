class DecksController < ApplicationController
  before_action :set_deck, only: [:show]

  def index
    @decks = policy_scope(Deck).joins(:curriculum).where("decks.curriculum_id = #{params[:curriculum_id]}")
  end

  def show
    authorize @deck
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end
end
