class CategoriesController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @categories = Category.includes(:payments).where(user_id: current_user.id)
    @user = current_user
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

  def payall
    @category = Category.includes(:payments).find(params[:category_id])
    @category.payments.each do |payment|
      payment.update(paid: true)
      payment.save
    end
    update_payments_list
  end
  
  private
  def update_payments_list
    @category = Category.includes(:payments).find(params[:category_id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('paybutton', partial: 'payments/paybutton', locals: { payment: @payment }),
          turbo_stream.replace('total', partial: 'payments/total', locals: { category: @category })
        ]
      end
    end
  end
  
  def category_params
    params.require(:category).permit(:name, :image)
  end
end
