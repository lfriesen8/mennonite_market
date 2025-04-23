class AddProvinceRefToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :province, foreign_key: true
  end
end
