require 'data_mapper'

class Comment
  include DataMapper::Resource

  property :id, Serial
  property :body, Text
end
