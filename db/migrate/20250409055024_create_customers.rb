class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :province, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end