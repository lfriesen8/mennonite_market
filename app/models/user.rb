class User < ApplicationRecord
  has_many :orders



  # If you're using roles (like admin)
  def admin?
    role == 'admin'
  end
end
