require 'sinatra'

# The code below will automatically require all the gems listed in our Gemfile,
# so we don't have to manually require gems a la
#
#   require 'data_mapper'
#   require 'dotenv'
#
# See: http://bundler.io/sinatra.html

require 'rubygems'
require 'bundler/setup'

# This requires all gems necessary regardless of environment (:default)
# and any environment-specific gems.
Bundler.require(:default, Sinatra::Application.environment)

# *Note*
#  Sinatra::Application.environment is set to the value of ENV['RACK_ENV']
#  if RACK_ENV is set.  Otherwise, it defaults to :development.

# Load the .env file if it exists
if File.exists?('.env')
  Dotenv.load('.env')
end

# Make sure you have all the environmental keys you need defined.
['DATABASE_URL', 'TWITTER_CONSUMER_KEY', 'TWITTER_CONSUMER_SECRET', 'TWITTER_ACCESS_TOKEN', 'TWITTER_ACCESS_TOKEN_SECRET'].each do |env_key|
  unless ENV.has_key?(env_key) && ! ENV[env_key].empty?
    puts "You don't have ENV['#{env_key}'] defined properly."
    puts "Read the readme and setup your .env correctly :)"
    exit 1
  end
end

# In development, the DATABASE_URL environment variable should be defined in the
# '.env' file. In production, Heroku will set this environment variable for you.
DataMapper.setup(:default, ENV['DATABASE_URL'])

# Display DataMapper debugging information in development
if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end
