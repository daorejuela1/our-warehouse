class TenantsController < ApplicationController
  before_action :authenticate_user!
  def update
    current_user.update!(tenant_params)
    redirect_to root_path, notice: "You are now in the team #{current_user.selected_tenant}"
  end

  def tenant_params
    params.require(:user).permit(:selected_tenant)
  end

end
