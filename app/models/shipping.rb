class Shipping < ActiveRecord::Base
  belongs_to :order
  belongs_to :buyer_id
end
