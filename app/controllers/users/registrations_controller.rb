class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    build_resource(sign_up_params)
    if !resource.save
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
      return
    end
    resource.account.card_token = params[:card_token]
    resource.account.plan = params[:user][:plan]
    resource.account.subscribe(name: resource.account.plan, plan: Plan::PLANS[resource.account.plan.downcase.to_sym])
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  rescue Pay::ActionRequired => e
    redirect_to pay.payment_path(e.payment.id)

  rescue Pay::Error => e
    resource.destroy
    flash[:alert] = e.message
    render :new
  end

  private

  def suscription_params
    params.require(:user).permit(:card_token, :plan, :processor)
  end
end 
