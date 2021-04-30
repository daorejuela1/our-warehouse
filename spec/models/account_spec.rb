require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#Validations' do
    let (:account) { build(:account) }

    it 'does not save with the same name' do
      account.save
      account2 = build(:account, name: "Company-1")
      expect(account2).not_to be_valid
    end
  end
end
