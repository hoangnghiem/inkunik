class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :billing_firstname
      t.string :billing_lastname
      t.string :billing_address
      t.string :billing_country
      t.string :billing_state
      t.string :billing_zipcode
      t.string :billing_phone
      t.string :shipping_firstname
      t.string :shipping_lastname
      t.string :shipping_address
      t.string :shipping_state
      t.string :shipping_country
      t.string :shipping_zipcode
      t.string :shipping_phone
      t.integer :shipping_method_id
      t.float :order_sub_total
      t.float :shipping_fee
      t.float :tax_fee
      t.string :promotion_code
      t.float :discount_amount
      t.float :order_total
      t.integer :order_status
      t.datetime :requested_date
      t.datetime :delivery_date

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
