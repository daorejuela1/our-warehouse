module SharedHelper
  def display_tenants_helper(current_user)
    account_list = []
    account_list.append(current_user.account.name + " (Admin)") unless current_user.account.nil?
    account_list.append(current_user.teams.uniq.pluck(:account_id).map {|x| Account.find(x).name})
    form_with url: edit_account_path,  method: :post do |form|
      concat form.select :account, account_list
      concat form.submit("Change Team", class: "btn btn-primary")
    end
  end
end
