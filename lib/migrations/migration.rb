require "active_record"
require_relative "../db_connection"
require "pry"

class CreateMyDataTable < ActiveRecord::Migration[5.0]
  def up
    create_table :my_data do |t|
      t.string :name
    end
  end

  def down
    drop_table :my_data
  end
end

binding.pry
