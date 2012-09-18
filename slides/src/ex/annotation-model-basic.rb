require 'data_mapper'

class Annotation
  include DataMapper::Resource

  property :id, Serial
  property :text, Text

  property :act_uid, String
  property :annotated_id, String

  belongs_to :user

  def self.for(act_uid)
    all(:act_uid => act_uid)
  end
end
