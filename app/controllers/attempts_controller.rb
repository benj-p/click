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
      completed_deck(@deck)
      redirect_to decksummary_user_path(@user, deck: @deck) if @attempt.save
    end
  end



  private

  def attempt_params
    params.permit(:response, :card_id)
  end

  def completed_deck(deck)
    teacher = deck.curriculum.user
    attempts = deck.attempts.where(user: current_user)
    correct = calculate_percent(attempts.where(response: "Correct").count, attempts.count)
    incorrect = calculate_percent(attempts.where(response: "Incorrect").count, attempts.count)
    unsure = calculate_percent(attempts.where(response: "I don't know").count, attempts.count)

    if correct > 75
      feed_event = FeedEvent.new(user: teacher, event_type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and scored #{ correct }%! Don't forget to say well done!"
      feed_event.save
    elsif incorrect > 75
      feed_event = FeedEvent.new(user: teacher, event_type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and scored #{ correct }%! Don't forget to follow up!"
      feed_event.save
    elsif unsure > 75
      feed_event = FeedEvent.new(user: teacher, event_type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and answered #{ unsure }% as unsure. Make sure you check in."
      feed_event.save
    end
  end

  def calculate_percent(attempts, total)
    (attempts / total) * 100
  end
end
