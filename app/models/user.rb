class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable, :omniauthable

  before_save :update_sid!
  before_save :check_status!

  validates :email, format: {
    with:    /\A.+@(.+\.kagawa-u\.ac\.jp\z|stu\.kagawa-u\.ac\.jp\z)/,
    message: 'は大学のもの(kagawa-u.ac.jp)を利用してください。'
  }

  LABORATORY = %w(無所属 富永研 林研 八重樫研 垂水研 安藤研 最所研 その他).freeze
  POSITION = %w(なし 会計 所長 副所長 会計 広報 物品 旅行 事務).freeze

  module Select
    ROLE = [['管理者', 100], ['一般', 0]]
    LABORATORY = LABORATORY.map.with_index { |labo, i| [labo, i] }
    POSITION = POSITION.map.with_index { |pos, i| [pos, i] }
  end

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

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?

    clean_up_passwords
    update_attributes(params, *options)
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

  def is_verified?
    100 <= status
  end

  def update_sid!
    self.sid = email.split('@').first
  end

  def check_status!
    flag = true
    skip_columns = %w(
      id
      encrypted_password
      reset_password_token
      reset_password_sent_at
      remember_created_at
      sign_in_count
      current_sign_in_at
      last_sign_in_at
      current_sign_in_ip
      last_sign_in_ip
      failed_attempts
      unlock_token
      locked_at
      role
      status
      created_at
      updated_at
    )
    self.class.columns.each do |col|
      target = col.name
      next if skip_columns.include?(target)
      flag = false unless try(target).present?
    end
    self.status = flag ? 100 : 0
  end
end
