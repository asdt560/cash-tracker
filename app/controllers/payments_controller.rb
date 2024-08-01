class PaymentsController < ApplicationController
  load_and_authorize_resource except: :create
  def index
    @user = current_user
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
      print @payment.errors.full_messages
    end
  end

  def pay
    @payment = Payment.find(params[:payment_id])
    print @payment
    @payment.update(paid: true)
    @payment.save
    update_payments_list
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

  def payment_params
    params.require(:payment).permit(:name, :amount, :paid, category_ids: [])
  end
end
