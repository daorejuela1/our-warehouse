module InviteHelper
  def get_team_name(account_id)
    Account.find(account_id).name
  end
end
