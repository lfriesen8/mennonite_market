# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :customer, optional: true

  has_many :order_items
  has_one :payment
  has_one :shipping

  # Allowlisted associations for ActiveAdmin filters
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "payment", "shipping", "user"]
  end

  # Allowlisted attributes for ActiveAdmin filters
  def self.ransackable_attributes(auth_object = nil)
    ["id", "created_at", "updated_at", "customer_id", "user_id", "status", "total_price", "gst", "pst", "hst"]
  end
end
