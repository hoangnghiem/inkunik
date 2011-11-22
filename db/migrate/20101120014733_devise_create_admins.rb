class DeviseCreateAdmins < ActiveRecord::Migration
  def self.up
    create_table(:admins) do |t|
      t.string :username
      t.database_authenticatable :null => false
      t.rememberable
      t.trackable
      t.references :role

      t.timestamps
    end

    add_index :admins, :username, :unique => true
    #add_index :admins, :reset_password_token, :unique => true
    # add_index :admins, :confirmation_token,   :unique => true
    # add_index :admins, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :admins
  end
end
