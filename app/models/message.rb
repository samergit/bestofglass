class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def read?(current_user)
    if self.user_id != current_user.id && self.read == false
      self.read = true
      self.save
    end
  end

end
