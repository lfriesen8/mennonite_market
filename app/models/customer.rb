# app/models/customer.rb
class Customer < ApplicationRecord
    has_many :orders
  
    validates :email, presence: true
    validates :province, presence: true
    validates :address, presence: true
  end
  