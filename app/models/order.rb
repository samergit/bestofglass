class Order < ActiveRecord::Base
  require "active_merchant/billing/rails"
  
  belongs_to :sellable, :polymorphic => true
  belongs_to :buyer, :class_name => 'Order', :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => 'Order', :foreign_key => 'seller_id'

  def create_number
    listing = self.sellable_id.to_s
    order_id = self.id.to_s
    slug = "1" + listing + "-" + order_id
    self.update_attribute(:number, slug)
  end


  def auction_process_order(amount, credit_card)
    response = gateway.purchase(self.amount * 100, credit_card)
    if response.success?
      self.update_attribute(:paid, true)
      puts "Purchase complete!"
    else
      redirect_to root_path
    end
  end

  def buy_process_order(amount, creditcard)
    if order.auction.is_active?
      response = gateway.purchase(self.amount * 100, creditcard)
      if response.success
        self.update_attribute(:paid, true)
        puts "Purchase complete!"
      else
        puts "Error: #{response.message}"
      end
    else
      flash[:error] = "Auction has already ended"
    end
  end


  def gateway
    ActiveMerchant::Billing::UsaEpayTransactionGateway.new(
      :login => "U6P5Dd5SXrGuGm9o0u2W96Z47FeBtdlH" )
  end


end
