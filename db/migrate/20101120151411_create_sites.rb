class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :domain
      t.string :site_code
      t.string :locale
      t.string :currency_code
      t.string :currency_symbol
      t.boolean :default

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
