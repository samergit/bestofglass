class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping_address
  belongs_to :billing_address
end
