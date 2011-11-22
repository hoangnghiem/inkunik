class CreateEmbroideryPrices < ActiveRecord::Migration
  def self.up
    create_table :embroidery_prices do |t|
      t.integer :site_id
      t.integer :min_qty
      t.integer :max_qty
      t.float :location1
      t.float :location2
      t.float :location3
      t.float :location4
      t.float :location5

      t.timestamps
    end
  end

  def self.down
    drop_table :embroidery_prices
  end
end
