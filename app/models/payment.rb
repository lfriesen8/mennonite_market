class Payment < ApplicationRecord
  belongs_to :order

  def self.ransackable_attributes(auth_object = nil)
    ["id", "order_id", "payment_method", "amount", "created_at", "updated_at"]
  end
end

