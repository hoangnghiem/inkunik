class UploadPhoto < ActiveRecord::Base
  has_attached_file :data,
                    :styles => { :medium => "190x190>", :thumb => "65x65>" },
                    :path => ":rails_root/public/images/user/upload_photos/:id/:style/:basename.:extension",
                    :url => "/images/user/upload_photos/:id/:style/:basename.:extension"
  #validates_attachment_presence :data
  #validates_attachment_content_type :data, :data_content_type => ['image/jpeg', 'image/png','image/gif'],
#											:message => 'file must be an image'
  
end
