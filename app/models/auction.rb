class Auction < ActiveRecord::Base
  belongs_to :bid
  belongs_to :artist
  belongs_to :comment
end
