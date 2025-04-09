class Shipping < ApplicationRecord
  belongs_to :order

  def self.ransackable_attributes(auth_object = nil)
    ["id", "order_id", "address", "city", "postal_code", "created_at", "updated_at"]
  end
end
