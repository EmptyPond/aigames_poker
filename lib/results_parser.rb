require 'pry'
require 'active_record'
require'json'
require_relative 'db_connection'

class My_data < ActiveRecord::Base
end

file = File.read("../resultfile.json")
data_hash = JSON.parse(file)
game_array = JSON.parse(data_hash["game"])


binding.pry
