class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :prefecture, presence: true, length: { maximum: 10 }
  validates :introduce, presence: true, length: { maximum: 255 }
  
  has_secure_password
  mount_uploader :picture, ImageUploader
end
