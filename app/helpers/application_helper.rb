module ApplicationHelper
  def opening_datetime(event)
    # rubocop:disable Metrics/LineLength
    dt = "#{event.opening_date.strftime('%A, %B %e')}, #{event.opening_start_time.strftime('%l:%M')}-#{event.opening_end_time.strftime('%l:%M %p')}"
    # rubocop:enable Metrics/LineLength
    dt.gsub!(/:00/, '')
    dt.gsub!(/^ /, '')
    dt.gsub(/  /, ' ')
    dt.gsub('- ', '-')
  end

  MAX_TWEET_LENGTH = 260.freeze

  # text for tweets
  def tweet_text(event)
    text = "At #{event.venue.name}"
    text += " @#{event.venue.twitter}" if event.venue.twitter.present?
    text += ": #{event.title}"
    text
  end
end
