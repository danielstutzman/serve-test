require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require './memoizable.rb'
require 'serve'
require 'serve/rack'
require 'action_view' # for Rails form helpers

# The project root directory
root = ::File.dirname(__FILE__)

require 'rack/piwik'
use Rack::Piwik, piwik_url: "http://162.243.28.101/analytics/"

# Other Rack Middleware
use Rack::ShowStatus      # Nice looking 404s and other messages
use Rack::ShowExceptions  # Nice looking errors

run Rack::Cascade.new([
  Rack::Directory.new(root + '/public'),
  Serve::RackAdapter.new(root + '/views')
])
