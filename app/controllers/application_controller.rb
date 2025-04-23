class ApplicationController < ActionController::Base 
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_categories
    @categories = Category.all
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :address, :province_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
