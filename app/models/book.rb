class Book < ApplicationRecord
  belongs_to :user
  belongs_to :kind
  
  validates :title, presence: true
  validates :author, presence: true
  validates :review, presence: true, length: { maximum: 255 }
end
