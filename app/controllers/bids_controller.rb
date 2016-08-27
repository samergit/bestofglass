class BidsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @bid = current_user.bids.new(bid_params)
    auction = @bid.auction
    path = URI(request.referer).path
    if auction.verified?(path) && auction.is_active? # && current_user != auction.user
      if auction.greatest_bid?(@bid.amount)
        @bid.save
        auction.update_columns(current_price: @bid.amount)
        auction.update_columns(highest_bidder: current_user.id) 
        redirect_to auction_path(auction.slug)
      else
        redirect_to auction_path(auction.slug)
      end
    end
  end

  private

    def bid_params
      params.require(:bid).permit(:amount, :auction_id)
    end
  
end
