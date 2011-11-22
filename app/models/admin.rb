class Admin < ActiveRecord::Base
  # AUTHENTICATION
  # --------------------------------------
  devise :database_authenticatable, :trackable, :timeoutable
  attr_accessible :username,:email, :password, :password_confirmation, :remember_me, :role_id
  
  # VALIDATION
  # --------------------------------------
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true

  # RELATIONSHIP
  # --------------------------------------
  belongs_to :role
  
  def super_admin?
    role.name == Role::SUPER_ADMIN    
  end

  def permissions
    Permission.joins(:roles => [:admins]).where(:admins => {:id => id})
  end
end
