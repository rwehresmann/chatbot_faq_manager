require_relative '../app.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
