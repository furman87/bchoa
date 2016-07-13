class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    # Fields for sign up
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }

    # Fields for editing an existing account
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :first_name, :last_name, :spouse_name, :street_number, :street_id, :phone_number, :spouse_phone, :spouse_email) }
  end
end
