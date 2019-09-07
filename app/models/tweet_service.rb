class TweetService
  # initialize with a list of events to tweet
  def initialize(events:)
    @events = events
    @client = Buffer::Client.new(ENV['BUFFER_ACCESS_TOKEN'])
  end

  def schedule_tweets
    @events.each do |event|
      data = buffer_data(event)
      next if data[:media].blank?

      response = @client.create_update(body: data)
      event.tweeted! if response.success?
    end
  end

  def buffer_data(event)
    data = {
      profile_ids: [ENV['BUFFER_PROFILE_ID']],
      text: tweet_text(event)
    }
    event.url.present? && data[:media] = { link: event.url }
    data
  end

  MAX_TWEET_LENGTH = 260

  # text for tweets
  def tweet_text(event)
    text = "At #{event.venue.name}"
    text += " @#{event.venue.twitter}" if event.venue.twitter.present?
    text += ": #{event.title}"
    text = text.truncate(MAX_TWEET_LENGTH) if text.length > MAX_TWEET_LENGTH
    text
  end
end
