class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_one :payment
  has_one :shipping
end
