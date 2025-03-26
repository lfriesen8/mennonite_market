class CreateShippings < ActiveRecord::Migration[7.2]
  def change
    create_table :shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.string :address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
