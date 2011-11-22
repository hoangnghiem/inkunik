class CreateDesignItems < ActiveRecord::Migration
  def self.up
    create_table :design_items do |t|
      t.integer :product_variant_id
      t.integer :design_id
      t.string  :ink_type
      t.text :front_design
      t.text :back_design
      t.text :left_design
      t.text :right_design
      t.integer :num_of_color
      t.integer :num_of_photo
      t.integer :num_of_location
      t.integer :total_quantity
      t.float :total_price

      t.timestamps
    end
  end

  def self.down
    drop_table :design_items
  end
end
