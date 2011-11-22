class CreateProductCategoryRelations < ActiveRecord::Migration
  def self.up
    create_table :product_category_relations do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :product_category_relations
  end
end
