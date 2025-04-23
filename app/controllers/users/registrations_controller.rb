class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Allow users to update profile without password
  def update_resource(resource, params)
    if params[:password].present?
      super
    else
      resource.update_without_password(params.except(:current_password))
    end
  end
end

