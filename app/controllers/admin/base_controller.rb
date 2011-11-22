class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to admin_root_url
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end
end
