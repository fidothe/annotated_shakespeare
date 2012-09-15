# encoding: utf-8

require 'sinatra/base'
require 'data_mapper'

ROOT_DIR = File.expand_path('../../', __FILE__)

# Classes which use DataMapper MUST be required 
# before this point.
path = File.expand_path('db/annotated_shakespeare.db', 
                        ROOT_DIR)
DataMapper.setup(:default, "sqlite://#{db_path}")

DataMapper.auto_upgrade!
