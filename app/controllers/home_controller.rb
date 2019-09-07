class HomeController < ApplicationController
  def index
    response.headers['Cache-Control'] = 'public, max-age=1800'
    @opening_soon = Event.opening_soon
    @open_now = Event.open_now
  end
end
