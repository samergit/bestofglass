class AuctionsController < ApplicationController
  before_filter :authenticate_user!,  except:  [:index, :show, :auction_timer]
  before_filter :check_auction_privileges!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
    @auction = Auction.find_by_slug(params[:slug])
    @item = @auction.item
    @bid = @auction.bids.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @auction = current_user.auctions.new
    @item = @auction.build_item
  end
  
  def edit
  end

  def create
    if params[:attachment]
      @auction = current_user.auctions.new(auction_params)
      if @auction.save
        @item = @auction.item
        @item.user = current_user
        @item.save
        @auction.create_slug(@item.artist, @item.title)
        params[:attachment].each do |key, val|
          @item.attachments.create(attachment: val)
        end
        render json: { message: "success", fileID: @auction.slug }, status: 200 
      end
    else
      render json: { error: 'no attachments'}, :status => 400
    end
  end


  def update
  end

  def destroy
  end

  def auction_timer
    @auction = Auction.find_by_slug(params[:slug])
    respond_to do |format|
        format.html
        format.js
      end
  end


  private
    def secure_params
      params.require(:user).permit(:role)
    end

    def auction_params
      params.require(:auction).permit(:id, :length, :starting_price, :reserve, :buy_it_now_price, :shipping_area, :shipping_price, item_attributes: [:id, :category, :artist, :title, :height, :joint, :perc, :description], attachments_attributes: [:attachment], bids_attributes: [:amount, :auction_id])
    end

end



