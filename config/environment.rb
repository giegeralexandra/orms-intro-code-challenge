require 'sqlite3'
require_relative '../lib/agent.rb'
require_relative '../lib/listing.rb'
DB = {:conn => SQLite3::Database.new("db/real_estate.db")}
