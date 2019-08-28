class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    #バリデーション
    validates :name, presence: true, length: { maximum: 25}
    validates :email, presence: true, length: {maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false}
    has_secure_password
    
end
