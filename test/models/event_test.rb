require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @venue = venues(:dckt)
    @neighborhood = @venue.neighborhood
    @event = Event.create!(
      venue: @venue,
      title: 'Matthew Craven',
      start_date: Time.zone.now.to_date,
      end_date: 60.days.from_now.to_date.to_s,
      opening_date: 30.days.from_now.to_date.to_s
    )
  end

  test "opening soon" do
    assert_equal Event.opening_soon, []
    @event.update(opening_date: 3.days.from_now.to_date.to_s)
    assert_equal [@event], Event.opening_soon
  end

  test "open now by neighborhood" do
    list = Event.open_now
    assert_equal list[0][0], @neighborhood.name
    events = list[0][1].to_a
    assert_equal [@event], events
  end

  test "url" do
    assert_equal "http://dcktcontemporary.com", @event.url
    @event.website = 'http://dcktcontemporary.com/exhibition/1'
    assert_equal 'http://dcktcontemporary.com/exhibition/1', @event.url
  end
end
