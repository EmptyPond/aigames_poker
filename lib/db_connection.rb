require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :database => "new_db",
  :host     => "localhost",
  :username => "ubuntu",
  :password => "password"
)
