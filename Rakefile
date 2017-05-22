require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
load 'pg_search/tasks.rb'
require 'rspec/core/rake_task'

task :default => :spec
RSpec::Core::RakeTask.new

require './app'
