class AttemptsController < ApplicationController
  def create
    @user = current_user
    @card = Card.find(params[:card_id].to_i)
    @deck = Deck.find(params[:deck_id].to_i)
    @question = params[:question].to_i + 1
    @attempt = Attempt.new(attempt_params)
    @attempt.user = @user
    authorize @attempt
    if @question < @deck.cards.count
      redirect_to takedeck_user_path(@user, deck: @deck.id, question: @question) if @attempt.save
    else
      redirect_to decksummary_user_path(@user, deck: @deck) if @attempt.save
    end
  end

  private

  def attempt_params
    params.permit(:response, :card_id)
  end
end
