require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#Validations' do
    let (:team) {build(:team)}

    it 'does not save if empty' do
      team.user = team.account = nil
      expect(team).not_to be_valid
    end

    it 'does not save without account' do
      team.account = nil
      expect(team).not_to be_valid
    end

    it 'does not save without user' do
      team.user = nil
      expect(team).not_to be_valid
    end

    it 'works with a newly created account and user' do
      expect(team).to be_valid
    end

    it 'cant link the same user with the same account' do
      user = create(:user)
      account = create(:account)
      new_team = create(:team, user: user, account: account)
      new_team2 = build(:team, user: user, account: account)
      expect(new_team).to be_valid
      expect(new_team2).not_to be_valid
    end

    it 'can link a different users with the same account' do
      user = create(:user)
      user2 = create(:user)
      account = create(:account)
      new_team = create(:team, user: user, account: account)
      new_team2 = build(:team, user: user2, account: account)
      expect(new_team).to be_valid
      expect(new_team2).to be_valid
    end

  end
end
