class User < ActiveRecord::Base
  devise :rememberable, :trackable, :recoverable,
         :omniauthable, :omniauth_providers => [:twitter]

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    where(auth.slice(:provider, :uid)).first_or_create(
      provider: auth.provider,
      uid: auth.uid,
      username: auth.info.nickname
    )
  end
end
