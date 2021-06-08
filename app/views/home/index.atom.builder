atom_feed do |feed|
  feed.title("filterizer.com")
  feed.updated(@events.last.created_at) if @events.length.positive?

  @events.each do |event|
    feed.entry(event, url: event.url) do |entry|
      entry.title(tweet_text(event))
    end
  end
end
