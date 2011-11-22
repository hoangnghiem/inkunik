class Checkout::CheckoutController < ApplicationController
  def signin
    @step = 1
  end

  def shipping_address
    @step = 2
  end

  def shipping_method
    @step = 3
  end

  def confirm
    @step = 4
  end

  def review
  end

end
