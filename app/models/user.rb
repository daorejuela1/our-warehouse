class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[a-zA-Z0-9\-\s]+\z/
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/
  validates :name, format: {with: VALID_NAME_REGEX, message: "Invalid name format, only the special character '-' & '  ' are accepted"}, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX, message: "Invalid email format"}, presence: true, uniqueness: {case_sensitive: false}
  validate :validate_email_layers
  has_one :account, inverse_of: :user
  accepts_nested_attributes_for :account
  has_many :teams
  has_many :accounts, through: :teams

  before_validation :set_account

  def is_admin?
    ActsAsTenant.current_tenant == account.id
  end

  def tenant_list
    account_list = []
    account_list.append(self.account.name + " (Admin)") unless self.account.nil?
    account_list.append(self.teams.uniq.pluck(:account_id).map {|x| Account.find(x).name}) unless self.teams.empty?
    account_list
  end

  private

  def join_team(account_id)
    teams.create!(account_id: account_id)
  end

  def quit_team
    teams.find_by(account_id: account.id).destroy
  end

  def set_account
    self.build_account(name: name) if self.account_id.nil?
    self.join_team(self.account_id) unless self.account_id.nil?
  end

  def validate_email_layers
    errors.add(:email, 'Invalid Email') if !email || !Truemail.valid?(email)
  end
end
