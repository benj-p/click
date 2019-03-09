class FeedEventsController < ApplicationController
  def completed_deck(deck)
    teacher = deck.curriculum.user
    attempts = deck.attempts.where(user: current_user)
    correct = calculate_percent(attempts.where(response: "Correct"), attempts.count)
    incorrect = calculate_percent(attempts.where(response: "Incorrect"), attempts.count)
    unsure = calculate_percent(attempts.where(response: "I don't know"), attempts.count)

    if correct > 75
      feed_event = FeedEvent.new(user: teacher, type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and scored #{ correct }%! Don't forget to say well done!"
      feed_event.save
    elsif incorrect > 75
      feed_event = FeedEvent.new(user: teacher, type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and scored #{ correct }%! Don't forget to follow up!"
      feed_event.save
    elsif unsure > 75
      feed_event = FeedEvent.new(user: teacher, type: EventType.first)
      feed_event.title = "#{ current_user.first_name } completed #{ deck.name } and answered #{ unsure }% as unsure. Make sure you check in."
      feed_event.save
    end
  end


  private

  def calculate_percent(attempts, total)
    (attempts / total) * 100
  end
end
