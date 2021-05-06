require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#Validations' do
    let (:account) { build(:account) }

    it 'saves correctly' do
      expect(account).to be_valid
    end

    it 'name can not have invalid characters' do
      account.name = "Hello!$#"
      expect(account).not_to be_valid
    end

    it 'does not save with the same name' do
      account = create(:account, name: "Company-1")
      account2 = build(:account, user: create(:user), name: "Company-1")
      expect(account).to be_valid
      expect(account2).not_to be_valid
    end
  end
end
