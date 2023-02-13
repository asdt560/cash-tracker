class UsersController < ApplicationController
  load_and_authorize_resource except: :create
  def index; end

  def show
    @user = current_user
  end
end
