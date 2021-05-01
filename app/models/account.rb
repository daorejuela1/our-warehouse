class Account < ApplicationRecord

  has_many :teams
  has_many :users, through: :teams

  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-\s]+\z/
  validates :name, format: {with: VALID_NAME_REGEX, message: "Invalid name format, only the special character '-' & '  ' are accepted"}, presence: true, uniqueness: {case_sensitive: false}
  belongs_to :user
end
