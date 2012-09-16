require 'data_mapper'

class Comment
  include DataMapper::Resource

  property :id, Serial
  property :body, Text

  property :commentable_type, String
  property :commentable_id, String
end
