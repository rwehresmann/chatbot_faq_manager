require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
load 'pg_search/tasks.rb'

begin
  require 'rspec/core/rake_task'
  task :default => :spec
  RSpec::Core::RakeTask.new
rescue LoadError => e
  puts "RSpec not available in this environment."
  puts e.message
end


require './app'
