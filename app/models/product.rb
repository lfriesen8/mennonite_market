class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :order_items

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :sale, inclusion: { in: [true, false] } # Add this line for sale validation

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "category_id", "stock_quantity", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items"]
  end
end
