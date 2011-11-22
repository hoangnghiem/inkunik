module ProductsHelper
  def show_notice?(variant)
    variant.min_order_qty > 1
  end
end
