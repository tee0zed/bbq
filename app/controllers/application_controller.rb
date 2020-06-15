class ApplicationController < ActionController::Base
  respond_to :html

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?, :current_user_sub?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end

  def current_user_sub?(event)
    user_signed_in? && event.subscribers.include?(current_user)
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
    model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end
end
