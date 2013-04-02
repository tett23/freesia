class Account
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :role, String
  property :uid, String
  property :provider, String

  def self.create_with_omniauth(auth)
    account = first_or_create({
      :uid => auth['uid'],
      :provider => auth['provider'],
      :name => auth['info']['name'],
      :role => :users
    })

    account
  end

  # omniauthがARを前提にしている
  def self.find_by_id(id)
    get(id)
  end
end
