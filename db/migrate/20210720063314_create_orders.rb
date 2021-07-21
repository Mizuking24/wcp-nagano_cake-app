class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.string :address
      t.integer :payment_method
      t.integer :delivery_charge
      t.integer :order_status
      t.integer :billing_amount

      t.timestamps
    end
  end
end
