class AddPriceAndTaxesToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :total_price, :decimal
    add_column :orders, :gst, :decimal
    add_column :orders, :pst, :decimal
    add_column :orders, :hst, :decimal
  end
end
