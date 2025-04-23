# app/models/customer.rb
class Customer < ApplicationRecord
  has_many :orders
  belongs_to :province

  validates :email, presence: true
  validates :province, presence: true
  validates :address, presence: true

  # Allow only specific attributes to be searchable in ActiveAdmin (Ransack)
  def self.ransackable_attributes(auth_object = nil)
    %w[address email id created_at updated_at province_id]
  end

  # Allow specific associations to be searchable
  def self.ransackable_associations(auth_object = nil)
    %w[province orders]
  end
end
