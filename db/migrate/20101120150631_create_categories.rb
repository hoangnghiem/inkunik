class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :site_id, :required => true
      t.string :name, :required => true
      t.integer :position
      t.integer :parent_id, :default => -1
      t.string :slug
      t.string :path, :required => true
      t.integer :sub_categories_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
