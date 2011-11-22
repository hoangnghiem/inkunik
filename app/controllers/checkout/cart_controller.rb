class Checkout::CartController < ApplicationController
  def add_to_cart
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def update_cart
  end

  def index
    
  end

end
