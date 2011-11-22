class Account::UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def edit
    @user = current_user    
  end

  def update
    
  end
end
