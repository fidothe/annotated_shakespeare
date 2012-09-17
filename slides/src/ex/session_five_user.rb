require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :credentials
  has n, :comments

  def self.from_auth_provider(provider, token)
    credential = Credential.first(:provider => provider, 
                                  :token => token)
    return credential.user if credential
    nil
  end

  def self.create_from_auth_provider(provider, token)
    user = User.create!
    credential = Credential.create!(:provider => provider, 
                                    :token => token, 
                                    :user => user)
    user
  end
end
