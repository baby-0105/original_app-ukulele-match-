class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receive_user, class_name: 'User'
  #belongs_to :receive_user_id_checked_message, class_name: 'Message'
  
  validates :content, presence: true, length: { maximum: 100 }
end
