desc "Send event tweets to Buffer "
task buffer_event_tweets: :environment do
  events = Event.opening_today.not_tweeted.limit(10)
  service = TweetService.new(events: events)
  service.schedule_tweets
end
