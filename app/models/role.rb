class Role < ActiveRecord::Base

  SUPER_ADMIN = "SUPER_ADMIN"

  # RELATIONSHIP
  # --------------------------------------
  has_many :admins, :dependent => :destroy
  has_and_belongs_to_many :permissions, :join_table => "role_permissions"

  # validation
  # --------------------------------------
  validates :name, :presence => true, :uniqueness => true
end
