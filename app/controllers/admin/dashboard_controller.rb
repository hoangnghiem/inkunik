class Admin::DashboardController < Admin::BaseController
  layout 'admin'
  authorize_resource :class => false

  def index
  end

end
