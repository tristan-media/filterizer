require 'test_helper'

class TweetServiceTest < ActiveSupport::TestCase
  def setup
    @venue = venues(:dckt)
    @event = Event.create!(
      venue: @venue,
      title: 'Matthew Craven',
      start_date: Time.zone.now.to_date,
      end_date: 60.days.from_now.to_date.to_s,
      opening_date: 30.days.from_now.to_date.to_s
    )
    @service = TweetService.new(events: [@event])
  end

  test "tweet text" do
    assert_equal "At DCKT Contemporary @DCKT: Matthew Craven", @service.tweet_text(@event)
    @event.venue.twitter = nil
    assert_equal "At DCKT Contemporary: Matthew Craven", @service.tweet_text(@event)
    @event.title = "long stuff " * 30
    assert @service.tweet_text(@event).length <= TweetService::MAX_TWEET_LENGTH
  end

  test "buffer url" do
    buffer_data = @service.buffer_data(@event)
    assert_equal "http://dcktcontemporary.com", buffer_data[:media][:link]
  end
end
