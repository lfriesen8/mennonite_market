class Category < ApplicationRecord
    has_many :products, dependent: :destroy  # Assuming each category has many products
  
    validates :name, presence: true, uniqueness: true
  end
  