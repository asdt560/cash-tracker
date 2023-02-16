class PaymentsController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @category = Category.find(params[:category_id])
    payments = Payment.joins(:categories).select { |a| a.category_ids.include?(@category.id) }
    @payments = payments.sort_by{ |obj| obj.created_at }.reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    @categories = Category.where(params[:category_ids])
    @payment = Payment.new(payment_params)
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
