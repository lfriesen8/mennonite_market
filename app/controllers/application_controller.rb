class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_categories
    @categories = Category.all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :province])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :province])
  end
end
