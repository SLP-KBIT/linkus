class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  before_save :update_sid!

  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first
    return update_google!(user, auth) if user

    User.create(
      name:     auth.info.name,
      provider: auth.provider,
      uid:      auth.uid,
      email:    auth.info.email,
      token:    auth.credentials.token,
      password: Devise.friendly_token[0, 20],
      raw: auth.to_json
    )
  end

  def self.update_google!(user, auth)
    user.update(
      name:     auth.info.name,
      provider: auth.provider,
      uid:      auth.uid,
      email:    auth.info.email,
      token:    auth.credentials.token,
      password: Devise.friendly_token[0, 20],
      raw: auth.to_json
    )
    user
  end

  def is_admin?
    100 <= role
  end

  def update_sid!
    self.sid = email.split('@').first
  end
end
