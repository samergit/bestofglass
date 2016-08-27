class Item < ActiveRecord::Base
  has_many :attachments, :as => :attachable
  belongs_to :user
  belongs_to :itemable, :polymorphic => true
end
