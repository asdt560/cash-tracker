class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource except: :create
  def index; end

  def show
    @user = current_user
  end
end
