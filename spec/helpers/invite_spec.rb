require 'rails_helper'
include InviteHelper

RSpec.describe InviteHelper, type: :helper do
  describe "#Validation get_team_name" do
    let (:user) {create(:user, account_name: "Company-1")}
    
    it 'returns account if id is not valid' do
      account_id = user.account.id
      team_name = get_team_name(account_id)
      expect(team_name).to eq("Company-1")

    end
    it 'returns nil if id is not valid' do
      account_id = user.account.id
      team_name = get_team_name(account_id + 1)
      expect(team_name).to be(nil)

    end
    it 'returns nil  if id is in other format' do
      account_id = "hello"
      team_name = get_team_name(account_id)
      expect(team_name).to be(nil)
    end
  end
end
