class Book < ApplicationRecord
  belongs_to :user
  belongs_to :kind
  
  validates :title, presence: true
  validates :author, presence: true
  validates :review, presence: true, length: {maximum: 255}
  validates :kind_id, presence: true
  
  
  has_many :goods, dependent: :destroy
end
