class PagesController < ApplicationController
  def home
    @User = User.all
    @auctions = Auction.all
  end	

end
