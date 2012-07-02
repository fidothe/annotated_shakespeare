require 'data_mapper'

class Comment
  include DataMapper::Resource

  property :id, Serial
  property :body, Text

  property :commentable_type, String
  property :commentable_id, String

  def self.for(type, id)
    Comment.all(:commentable_type => type.to_s, :commentable_id => id.to_s)
  end
end
