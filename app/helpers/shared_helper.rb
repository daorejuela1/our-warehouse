module SharedHelper
  def display_tenants_helper(current_user)
    form_with url: edit_account_path,  method: :post do |form|
      concat form.select :account, current_user.tenant_list
      concat form.submit("Change Team", class: "btn btn-primary")
    end
  end
end
