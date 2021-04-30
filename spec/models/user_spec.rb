require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#Validations' do
    let (:user) {build(:user)}

    it 'does not save if empty' do
      user.name = user.password = user.email = user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'does not save if name is empty' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'does not save if email is empty' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'does not save if email has invalid format' do
      user.email = "daorejuela1@outlook"
      expect(user).not_to be_valid
    end

    it 'saves correctly' do
      expect(user).to be_valid
      new_user = build(:user, email: "daorejuela1@outlook.com")
      expect(new_user).to be_valid
    end

  end
end
