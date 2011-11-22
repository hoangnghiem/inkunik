class CreateDesignItemOptions < ActiveRecord::Migration
  def self.up
    create_table :design_item_options do |t|
      t.integer :design_item_id
      t.string :garment_size_name
      t.string :garment_color_name
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :design_item_options
  end
end
