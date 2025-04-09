# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["id", "created_at", "updated_at", "order_id", "product_id", "quantity", "price"]
  end
end