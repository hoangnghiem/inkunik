class CreateProductVariants < ActiveRecord::Migration
  def self.up
    create_table :product_variants do |t|
      t.string :sku
      t.integer :product_id
      t.string :fabric
      t.integer :min_order_qty, :default => 0
      t.float :price
      t.float :blank_shirt_price
      t.boolean :active, :default => true
      t.boolean :default
      t.string :colors
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :product_variants
  end
end
