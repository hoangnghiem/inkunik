class Permission < ActiveRecord::Base
  # RELATIONSHIP
  # --------------------------------------
  has_and_belongs_to_many :roles, :join_table => "role_permissions"
end
