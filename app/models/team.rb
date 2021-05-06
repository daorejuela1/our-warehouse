class Team < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :account, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
end
