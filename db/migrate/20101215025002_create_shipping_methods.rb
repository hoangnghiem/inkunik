class CreateShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods do |t|
      t.string :shipping_method_name
      t.string :unit
      t.float :shipping_rate
      t.string :active_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_methods
  end
end
