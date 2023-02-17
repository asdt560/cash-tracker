class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource except: :create
  def index; end
end
