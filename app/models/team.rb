class Team < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :account, presence: true, uniqueness: true
  validates :user, presence: true
end
