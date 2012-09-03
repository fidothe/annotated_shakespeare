require 'data_mapper'

class Credential
  include DataMapper::Resource

  property :id, Serial
  property :provider, String
  property :token, String

  belongs_to :user
end
