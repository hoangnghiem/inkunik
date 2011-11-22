class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new
    if admin.super_admin?  
      can :manage, :all
    else
      admin.permissions.each do |permission|
        if permission.model
          can permission.action.to_sym, permission.object_type.constantize do |object|
            object.nil? || permission.object_id.nil? || permission.object_id == object.id
          end
          #can permission.action.to_sym, permission.object_type.constantize
        else
          can permission.action.to_sym, permission.object_type.downcase.to_sym
        end
      end
    end
  end
end
