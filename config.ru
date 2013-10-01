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

# Other Rack Middleware
use Rack::ShowStatus      # Nice looking 404s and other messages
use Rack::ShowExceptions  # Nice looking errors

run Rack::Cascade.new([
  Serve::RackAdapter.new(root + '/views'),
  Rack::Directory.new(root + '/public')
])
