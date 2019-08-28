ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'  #files within my directory
require 'sinatra/activerecord/rake' #used for external files ie gems--enabling active record rake tasks


ENV["SINATRA_ENV"] ||= "development"

task :console do  # raketask to start up pry console
  Pry.start 
end 