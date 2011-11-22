class CreateUploadPhotos < ActiveRecord::Migration
  def self.up
    create_table :upload_photos do |t|
      t.integer :user_id
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :upload_photos
  end
end
