class PaymentsController < ApplicationController

  before_action :require_login
  skip_before_action :verify_authenticity_token

  def new 
    @client_token = Braintree::ClientToken.generate
    @Acts_as_bookable_booking = Acts_as_bookable_booking.find(params[:format])
    @payment = Payment.new
  end

  def create
    amount = params[:payment][:total_price]
    nonce = params[:payment_method_nonce]

    render action: :new and return unless nonce

    @result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: params[:payment_method_nonce]
    )

    if @result.success?
      @payment=Payment.create(acts_as_bookable_booking_id: params[:payment][:Acts_as_bookable_booking_id], braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
      @payment.save!
        redirect_to success_path(:id => params[:payment][:Acts_as_bookable_booking_id]), notice: "Congratulations! Your transaction is successful!"
    else
        Payment.create(acts_as_bookable_booking_id: params[:payment][:Acts_as_bookable_booking_id], braintree_transaction_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        @client_token = Braintree::ClientToken.generate
        @Acts_as_bookable_booking = Acts_as_bookable_booking.find(params[:payment][:Acts_as_bookable_booking_id])
        @payment = Payment.new
        render :new
    end


  end
end