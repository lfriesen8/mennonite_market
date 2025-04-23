class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def edit_profile
      @user = current_user
    end
  
    def update_profile
      @user = current_user
      if @user.update(user_params)
        redirect_to root_path, notice: 'Profile updated successfully.'
      else
        flash.now[:alert] = 'Failed to update profile.'
        render :edit_profile
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :address, :province_id)
    end
  end
  
