class CreateDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.integer :product_variant_id
      t.string  :ink_type
      t.text :canvas_data
      t.text :front_design
      t.text :back_design
      t.text :left_design
      t.text :right_design
      t.string :design_name
      t.integer :num_of_color
      t.integer :num_of_photo
      t.integer :num_of_location
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :designs
  end
end
