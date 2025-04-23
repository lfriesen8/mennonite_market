class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  belongs_to :province, optional: true  # Keep optional if province isn't mandatory on sign up

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :address, presence: true
  validates :province, presence: true, unless: -> { province.nil? }  # prevents error during guest flows

  # Role helper
  def admin?
    role == 'admin'
  end
end

