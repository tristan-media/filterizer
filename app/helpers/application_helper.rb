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
end
