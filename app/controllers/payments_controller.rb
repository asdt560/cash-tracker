class PaymentsController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @category = Category.includes(:payments).find(params[:category_id])
    @payments = @category.payments.sort_by(&:created_at).reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    @categories = Category.where(params[:category_ids])
    params = payment_params
    params[:amount] = (params[:amount].to_f * 100).to_i
    print params
    @payment = Payment.new(params)
    @payment.author_id = current_user.id
    if @payment.save
      redirect_to category_payments_path, notice: 'Payment was successfully created.'
    else
      redirect_to category_payments_path, notice: 'Payment was not created.'
    end
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, category_ids: [])
  end
end
