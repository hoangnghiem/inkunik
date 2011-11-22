module Admin::RolesHelper
  def dashboard?(name)
    name == "Dashboard"
  end

  def checked_if_dashboard?(role_perms, permission)
    return true if permission.name == "Dashboard" 
    return false if params[:action] == "new"
    role_perms.include?(permission.id)
  end
end
