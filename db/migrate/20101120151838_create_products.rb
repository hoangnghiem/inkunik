class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :printable
      t.boolean :embroiderable
      t.string :slug
      t.boolean :active, :default => true
      t.integer :product_variants_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
