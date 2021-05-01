class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :set_current_account

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name] )
    devise_parameter_sanitizer.permit(:invite, keys: [:account_id] )
  end

  private

  def set_current_account
    return unless current_user.present?
    current_account = current_user.account
    ActsAsTenant.current_tenant = current_account
  end

end
