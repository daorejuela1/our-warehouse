class Users::InvitationsController < Devise::InvitationsController

  def edit
    set_minimum_password_length
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  private
  def update_resource_params
    params.require(:user).permit(:name, :email, :invitation_token, :password, :password_confirmation)
  end
end
