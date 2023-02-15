class CategoriesController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @categories = Category.includes(:payments).where(user_id: current_user.id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      redirect_to categories_path, notice: 'Category was not created.'
    end
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
