class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource except: :create
  def index; end

  def show
    @user = current_user
    @current_payments = 0
    @total_payments = 0
    @user.categories.each do |category|
      @current_payments += category.pending_payments
      @total_payments += category.sum_of_payments
    end
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
