# setup.rb makes sure we're setting up our environment correctly, i.e.,
# requiring the necessary gems, connecting to the correct database, etc.
require './setup'

# database.rb is where we're defining our DataMapper models
require './database'

SPOTIFY = 'https://api.spotify.com/v1'

def twitter_client
  return @client unless @client.nil?

  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end
end

get("/album") do
  if params[:name]
    spotify_query_url = URI.encode("#{SPOTIFY}/search?q=#{params[:name]}&type=album") 
    Excon.get(spotify_query_url).body
  end
end
