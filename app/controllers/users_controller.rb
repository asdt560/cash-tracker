class UsersController < ApplicationController
  load_and_authorize_resource except: :create
  def index
  end
end