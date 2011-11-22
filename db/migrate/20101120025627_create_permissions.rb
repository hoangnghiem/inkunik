class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :name
      t.string :action
      t.string :object_type
      t.boolean :model, :default => true

      t.timestamps
    end

    create_table :role_permissions, :id => false do |t|
      t.references :role
      t.references :permission
    end
  end

  def self.down
    drop_table :permissions
    drop_table :role_permissions
  end
end
