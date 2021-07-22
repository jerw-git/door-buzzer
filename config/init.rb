require 'sinatra'
require 'sinatra/sequel'
# switch to postgres for Heroku
 
configure :development do
  set :database, 'sqlite://development.db'
  require 'sqlite3'
end

configure :production do
  Sequel.connect(ENV['DATABASE_URL'])
end
 
require './config/migrations'

#Add our data (tours & dates) from the file config/data.rb
require './config/data'