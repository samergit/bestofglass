class User < ActiveRecord::Base
  after_create :touch_activity
  attr_accessor :login 
   enum role: [:user, :artist, :shop, :distributor, :admin]

  def set_default_role(path)
    if path == '/artist/signup'
      self.role = :artist
      self.save
    else
      self.role = :user
      self.save
    end  
  end

  validates :date_of_birth, :presence => true
  validates_inclusion_of :date_of_birth, :in=>Date.new(1916)..Time.now.years_ago(18).to_date, :message=>'You must be 18 years or older'
  validates :email, uniqueness: true
  validates :username, 
    :uniqueness =>{
      :case_sensitive => false
    } 
  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
 
 #login with username
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
  end

  def touch_activity
    self.touch :last_viewed_messages_page, :last_viewed_activity_page, :last_received_message
  end

  #messages for convos
  has_many :messages

  #auctions
  has_many :auctions

  #bids
  has_many :bids

  #won auctions
  has_many :won_auctions, :class_name => 'Auction', :foreign_key => 'winner_id'
  has_many :buy_orders, :class_name => 'Order', :foreign_key => 'buyer_id'
  has_many :sell_orders, :class_name => 'Order', :foreign_key => 'seller_id'

  #comments for auctions
  has_many :comments

  #comments for auctions
  has_many :notifications

  #comments for auctions
  has_many :orders

  #items
  has_many :items
  
#follower relationships
  has_many :followed_users, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", 
                                                                dependent: :destroy                                                          
  has_many :followers, through: :reverse_relationships, source: :follower
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id) 
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  #grab list conversations for display in user inbox
  def conversations
    conversations = Conversation.where("sender_id = ? OR recipient_id = ?", self, self)
    return conversations
  end

  #check to  see if conversation between two users already exist during creation
  def convo_check(recipient)
    @recipient = recipient 
    if Conversation.where(sender_id: self.id, recipient_id: @recipient.id).present?
      @conversation =  Conversation.where(sender_id: self.id, recipient_id: @recipient.id).first
      return @conversation
    elsif  
      Conversation.where(sender_id: @recipient.id, recipient_id: self.id).present?
        @conversation = Conversation.where(sender_id: @recipient.id, recipient_id: self.id).first
        return @conversation
    else 
      return false    
    end
  end

  #auctions permissions 
  def seller_verified?
    if self.artist? && self.approved || self.shop? && self.approved
      return true
    end
  end

  #updating user roles
  def make_artist
    self.artist!
  end

  def approve_artist
    self.update_attribute(:approved, true)
  end

  def unapprove_artist
    self.update_attribute(:approved, false)
  end

  def make_user
    self.user!
  end

  def ban_user
    self.update_attribute(:banned, true)
  end

  def unban_user
    self.update_attribute(:banned, false)
  end


end

