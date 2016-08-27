class Auction < ActiveRecord::Base
  belongs_to :user
  has_one :winner, :class_name => 'User', :foreign_key => 'winner_id'
  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  has_many :bids, :dependent => :destroy
  has_one :item, :as => :itemable
  accepts_nested_attributes_for :item
  validates :item, presence: true
  has_one :order, :as => :sellable
  has_many :notifications, :as => :notifiable

  def display_time_remaining
    auction_duration = self.length.minutes
    time = Time.now - self.created_at.to_time # calculates how much time has passed since auction created
    time_left_in_seconds = (auction_duration - time) # calculates time remaining in seconds
    seconds = time_left_in_seconds 
    days = (seconds / 86400).floor
    seconds %= 86400
    hours = (seconds / 3600).floor
    seconds %= 3600
    minutes = (seconds / 60).floor
    seconds %= 60
    seconds = seconds.floor
    if time_left_in_seconds >= 0
      if days > 0
        return days.to_s + 'd' + ' ' + hours.to_s + 'h' + ' ' + minutes.to_s + 'm' 
      elsif days == 0 && hours > 0
        return hours.to_s + 'h' + ' ' + minutes.to_s + 'm' +  ' '  + seconds.to_s + 's'
      elsif days == 0 && hours == 0 && minutes > 0
        return minutes.to_s + 'm' +  ' '  + seconds.to_s + 's'
      else 
        return seconds.to_s + 's'
      end
    else
      return "Auction has ended."
    end
  end

  def js_time_left
    auction_duration = self.length.minutes
    time = Time.now - self.created_at.to_time # calculates how much time has passed since auction created
    seconds = (auction_duration - time) # calculates time remaining
    return seconds
    # else
    #   return 'over'
    # end
  end



  def is_active?
    if  Time.now > ( self.created_at.to_time + self.length.minutes ) && self.active?
      final_price = self.current_price
      self.update_columns(final_price: final_price)
      self.update_columns(active: false)
      if self.bids.present? && (final_price >= self.reserve)
        self.update_columns(winner_id: self.highest_bidder) 
        @order = Order.create!(:sellable_id => self.id, :buyer_id => self.highest_bidder, :seller_id => self.user_id, :sellable_type => "Auction", :amount => self.final_price)
        @order.create_number
      end
      return  false
    elsif self.active == false
      return false
    elsif  Time.now <  (self.created_at.to_time + self.length.minutes) && self.active?
      return true
    end
  end

  def create_slug(artist, title)
    artist = artist.downcase.parameterize("-")
    title = title.downcase.parameterize("-")
    id = self.id.to_s
    slug = artist + "-" + title + "-" + id
    self.update_attribute(:slug, slug)
  end

  def greatest_bid?(bid_amount)
    greater_check = true
    increment = bid_amount - self.current_price
    if ( bid_amount <= self.current_price ) || ( increment < self.price_increment )
      greater_check = false
    end
    return greater_check
  end

  def verified?(previous_path)
    if self.id.to_s == previous_path.split('-')[-1]
      return true
    else
      return false
    end
  end

  def self.auction_runner
    active_auctions = Auction.where("active = ?", true)
    active_auctions.each do |auction|
      auction.is_active?
    end
  end

end
