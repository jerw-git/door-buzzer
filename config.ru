require 'rubygems'
require 'bundler'

Bundler.require

require './app'

## There is no need to set directories here anymore;
## Just run the application

run Sinatra::Application