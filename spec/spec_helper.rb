require 'pry-byebug'
require 'rake'
require 'rspec'
require 'active_nutrition'

db_file = File.expand_path('../fixtures/sr24.sqlite3', __FILE__)
db_url = 'https://github.com/forrager/active_nutrition/releases/download/sr24/sr24.sqlite3'

unless File.exist?(db_file)
  puts "active_nutrition needs a pre-built USDA database to run tests. "\
    "Please download the SR24 database from the github releases page and "\
    "save it to #{db_file}. The url is #{db_url}."

  exit 1
end

ActiveRecord::Base.establish_connection(
  pool: 5,
  timeout: 5000,
  adapter: 'sqlite3',
  database: db_file
)

RSpec.configure do |config|
  # config (if necessary) goes here
end
