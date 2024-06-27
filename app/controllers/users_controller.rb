class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource except: :create
  def index; end

  def show
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      redirect_to profile_path, notice: 'User was not updated.'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
