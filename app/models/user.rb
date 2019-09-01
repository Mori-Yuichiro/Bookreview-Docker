class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    #バリデーション
    validates :name, presence: true, length: { maximum: 25}
    validates :email, presence: true, length: { maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false}
    validates :password, presence: true, length: { maximum: 20}
    has_secure_password
    
    has_many :books
    has_many :goods
    has_many :goodings, through: :goods, source: :book
    has_many :reverses_of_good, class_name: 'Good', foreign_key: 'book_id'
    has_many :gooders, through: :reverses_of_good, source: :user
    
    def good(other_book)
       unless self == other_book
            self.goods.find_or_create_by(book_id: other_book.id)
       end
    end
    
    def ungood(other_book)
       good = self.goods.find_by(book_id: other_book.id)
       good.destroy if good
    end
    
    def gooding?(other_book)
       self.goodings.include?(other_book) 
    end
end

