module SharedHelper
  def display_tenants_helper(current_user)
    form_with url: edit_account_path,  method: :post do |form|
      concat form.label :account
      concat form.select :account, current_user.tenant_list
      concat form.submit("Change Team", class: "btn btn-primary")
    end
  end

  def get_current_account_name
    concat ActsAsTenant.current_tenant.name + " (Admin)" if current_user.is_admin?
    ActsAsTenant.current_tenant.name + " (User)" unless current_user.is_admin?
  end
end
