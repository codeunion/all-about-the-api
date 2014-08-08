# We point DataMapper to the correct database in setup.rb
require './setup'

# class Report
#   include DataMapper::Resource
# end

# These two lines tell DataMapper that you've defined all your models; and to
# prepare the database for writing and reading. It also makes sure the databases
# `schema` (or "structure" or "shape") matches the `DataMapper::Resource`s
# you've defined above.
DataMapper.finalize
DataMapper.auto_upgrade!
