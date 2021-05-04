class Account < ApplicationRecord
  include Pay::Billable

  has_many :teams, dependent: :destroy
  has_many :users, through: :teams, dependent: :destroy

  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-\s]+\z/
  validates :name, format: {with: VALID_NAME_REGEX, message: "Invalid name format, only the special character '-' & '  ' are accepted"}, presence: true, uniqueness: {case_sensitive: false}
  belongs_to :user
  before_validation :set_processor



  def email
    user.email
  end

  def set_processor
    self.processor = :stripe
  end
end
