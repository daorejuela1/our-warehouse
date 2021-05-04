module SharedHelper
  def display_tenants_helper(current_user)
    form_with model: current_user,  url: tenants_path,  method: :put do |form|
      concat form.select :selected_tenant, current_user.tenant_list
      concat form.submit("Switch", class: "form-inline btn btn-primary ml-2")
    end
  end

  def get_current_plan
    subscription = ActsAsTenant.current_tenant.subscriptions.find { |dict| dict['status'] == 'active'  }
    "Plan: #{ subscription ? subscription.name : "Free"  }"
  end

  def get_current_account_name
    concat ActsAsTenant.current_tenant.name + " (Admin)" if current_user.is_admin?
    ActsAsTenant.current_tenant.name + " (User)" unless current_user.is_admin?
  end
end
