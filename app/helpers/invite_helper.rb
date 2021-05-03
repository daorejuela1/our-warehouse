module InviteHelper
  def get_team_name(account_id)
    account = Account.find_by(id: account_id)
    account.name unless account.nil?
  end
end
