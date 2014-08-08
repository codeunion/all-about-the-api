# setup.rb makes sure we're setting up our environment correctly, i.e.,
# requiring the necessary gems, connecting to the correct database, etc.
require './setup'

# database.rb is where we're defining our DataMapper models
require './database'

SPOTIFY = 'https://api.spotify.com/v1'


get("/music/album") do
  if params[:name]
    url = spotify_url(params[:name], 'album')
    Excon.get(spotify_query_url).body
  else
    try_again
  end
end

get("/music/artist") do
  if params[:name]
    url = spotify_url(params[:name], 'artist')
    Excon.get(spotify_query_url).body
  else
    try_again
  end
end

get("/music/track") do
  if params[:name]
    url = spotify_url(params[:name], 'track')
    Excon.get(spotify_query_url).body
  else
    try_again
  end
end

get("/chatter/hash_tag_search") do
  if params[:hashtag]
    get_tweets(params[:hashtag])
  else
    try_again
  end
end

def twitter_client
  return @client unless @client.nil?
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end
end

def get_tweets(hashtag)
  twitter_client.search(hashtag).inspect
end

def spotify_url(query, type)
  URI.encode("#{SPOTIFY}/search?q=#{query}&type=#{type}") 
end

def try_again
  "please check your query"
end
