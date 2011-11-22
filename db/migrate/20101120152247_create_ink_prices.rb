class CreateInkPrices < ActiveRecord::Migration
  def self.up
    create_table :ink_prices do |t|
      t.integer :site_id
      t.integer :min_qty
      t.integer :max_qty
      t.float :color1
      t.float :color2
      t.float :color3
      t.float :color4
      t.float :color5
      t.float :color6
      t.float :color7
      t.float :color8
      t.float :color9
      t.float :color10
      t.float :color11
      t.float :color12

      t.timestamps
    end
  end

  def self.down
    drop_table :ink_prices
  end
end
