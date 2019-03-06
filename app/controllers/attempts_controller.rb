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
      redirect_to dashboard_user_path(@user) if @attempt.save
    end
    # raise
  end

  # def create
  #   @personality = Personality.find(params[:personality_id])
  #   @booking = Booking.new(booking_params)
  #   @booking.user = current_user
  #   @booking.personality = @personality
  #   authorize @booking
  #   if @booking.save
  #     redirect_to dashboard_user_path(current_user)
  #   else
  #     render template: "personalities/show"
  #   end
  # end

  private

  def attempt_params
    params.permit(:response, :card_id)
  end
end
