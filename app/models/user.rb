class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-\s]+\z/
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/
  validates :name, format: {with: VALID_NAME_REGEX, message: "Invalid name format, only the special character '-' & '  ' are accepted"}, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX, message: "Invalid email format"}, presence: true, uniqueness: {case_sensitive: false}
  validate :validate_email_layers
  has_one :account, inverse_of: :user
  accepts_nested_attributes_for :account

  before_validation :set_account

  private

  def set_account
    self.build_account(name: name)
  end

  def validate_email_layers
    errors.add(:email, 'Invalid Email') if !email || !Truemail.valid?(email)
  end
end
