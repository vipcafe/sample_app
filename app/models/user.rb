class User < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
            uniqueness: true,
            length: {maximum: Settings.user.max_length},
            format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: Settings.password.min_length}
  before_save :downcase_email
  has_secure_password
  def downcase_email
    email.downcase!
  end
end
