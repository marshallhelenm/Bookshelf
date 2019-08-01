require_relative 'config/environment'
require 'sinatra/activerecord/rake'


desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end


desc 'run program'
task :run do 
  BookshelfCLI.run
end