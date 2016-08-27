class OrdersController < ApplicationController

  def show
  end

  def check_out
    @order = Order.find(1)
    @credit_card = ActiveMerchant::Billing::CreditCard.new
  end


  def update
    @order = Order.find(1)
    @credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card])
    @order.auction_process_order(@order.amount, @credit_card)
  end

end
