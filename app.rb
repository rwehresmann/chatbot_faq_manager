require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/queries/*.rb"].each { |file| require file }


Dir["./app/services/**/*.rb"].each { |file| require file }
require './app/classes/utils.rb'
Dir["./app/classes/**/*.rb"].each { |file| require file }


class App < Sinatra::Base
  get '/sinatra' do
    'Hello world Sinatra!'
  end

  # Example of how to test with curl:
  # curl -H "Content-Type: application/json" -X POST -d '{ "result": { "source": "agent", "resolvedQuery": "help", "action": "help", "actionIncomplete": false, "parameters": {}, "contexts": [], "metadata": { "intentId": "3314997b-0428-4efb-808c-f3708f059a85", "webhookUsed": "true", "webhookForSlotFillingUsed": "false", "webhookResponseTime": 36, "intentName": "help" } } }' http://localhost:9292/webhook
  post '/webhook' do
    result = JSON.parse(request.body.read, symbolize_names: true)[:result]
    if result["contexts"].present?
      response = Interpreter.call(
        result[:action],
        result[:contexts][0][:parameters]
      )
    else
      response = Interpreter.call(result[:action], result[:parameters])
    end

    content_type :json
    {
      "speech" => response,
      "displayText" => response,
      "source" => "Slack"
    }.to_json
  end
end
