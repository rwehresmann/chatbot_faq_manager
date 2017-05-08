require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
