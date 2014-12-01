class Authenticator < ActiveRecord::Base
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true

  def self.find_or_create_by_auth_hash(auth_hash)
    provider = auth_hash['provider']
    uid = auth_hash['uid']

    existing_authenticator = where(provider: provider, uid: uid).take
    if existing_authenticator.present?
      existing_authenticator.user
    else
      email_address = auth_hash['info']['email']
      user = User.where(email_address: email_address).take
      unless user.present?
        name = auth_hash['info']['name']
        user = User.create!(name: name, email_address: email_address)
      end

      token  = auth_hash['credentials']['token']
      secret = auth_hash['credentials']['secret']

      create!(
        provider: provider,
        uid: uid,
        user: user,
        token: token,
        secret: secret
      )

      user
    end
  end
end
