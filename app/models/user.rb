class User < ApplicationRecord
  attr_accessor :remember_token ,:activation_token
  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true,
            uniqueness: true,
            length: {maximum: 500},
            format: {with: VALID_EMAIL_REGEX}

  validates :password, presence: true,
            length: {minimum: 6}, allow_nil: true
  before_save :downcase_email
  has_secure_password

  # Returns true if the given token matches the digest.
  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
  return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  # Returns the hash digest of the given string.
  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute :remember_digest, nil
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Activates an account.
  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  private
  def downcase_email
    self.email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
