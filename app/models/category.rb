class Category < ApplicationRecord
  has_many :products, dependent: :destroy  # Assuming each category has many products
  
  validates :name, presence: true, uniqueness: true

  # Allow Ransack to search the Category attributes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]  # Explicitly define attributes to search
  end
  
  # Allow Ransack to search the 'products' association
  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end
end
