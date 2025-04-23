class RemoveProvinceFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :province, :string
  end
end
