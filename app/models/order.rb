class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :customer, optional: true

  has_many :order_items, inverse_of: :order, dependent: :destroy
  has_one :payment
  has_one :shipping

  accepts_nested_attributes_for :order_items, allow_destroy: true

  STATUSES = %w[new paid shipped]
  validates :status, inclusion: { in: STATUSES }
  after_initialize :set_default_status, if: :new_record?

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "payment", "shipping", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "created_at", "updated_at", "customer_id", "user_id", "status", "total_price", "gst", "pst", "hst"]
  end

  private

  def set_default_status
    self.status ||= 'new'
  end
end

