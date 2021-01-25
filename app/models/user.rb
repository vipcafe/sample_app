class User < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
  uniqueness: true,
  length: {maximum: 500},
  format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: 6}
  before_save :downcase_email
  has_secure_password

  def downcase_email
    # self.email.downcase!
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
end
