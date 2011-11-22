class Quote
  include ActiveModel::Validations
  attr_accessor :product, :product_id, :ink_type, :num_of_colors, :num_of_locations, :quantities, :price, :variant, :variant_id
  validates_with QuoteValidator

  def self.build_quote(params)
    quote = Quote.new
    quote.product_id = params[:product_id]
    quote.variant_id = params[:variant_id]
    quote.ink_type = params[:ink_type]
    if quote.ink_type.blank?
      quote.ink_type = quote.product.printable ? Product::INK_TYPES[:ink] : Product::INK_TYPES[:embroidery]
    end
    quote.num_of_colors = params[:num_of_colors]
    quote.num_of_locations = params[:num_of_locations]
    quote.quantities = params[:quantities]
    quote
  end
  
  def ink?
    @ink_type == Product::INK_TYPES[:ink]
  end

  def embroidery?
    @ink_type == Product::INK_TYPES[:embroidery]
  end

  def product
    @product ||= Product.find(@product_id)
  end

  def product_variant
    @variant ||= ProductVariant.find(@variant_id)
  end

  def total_quantity
    return 0 if @quantities.blank?
    @quantities.values.map {|x| x.to_i}.sum
  end

  def total_price
    price_per_unit * total_quantity
  end

  def price_per_unit
    target = target_in_range
    price_per_unit = 0
    if self.ink?
      if self.num_of_colors.to_i > 12
        for num in 1..12
          price_per_unit += target.send("color#{num}")
        end
        for num in 13..self.num_of_colors.to_i
          price_per_unit += target.send("color12")
        end
      else
        for num in 1..self.num_of_colors.to_i
          price_per_unit += target.send("color#{num}")
        end
      end
    else
      for num in 1..self.num_of_locations.to_i
        price_per_unit += target.send("location#{num}")
      end
    end   
    price_per_unit += self.product_variant.price
  end

  def target_in_range
    price_target = self.ink? ? InkPrice : EmbroideryPrice
    target = nil
    if total_quantity <= 100 # get min price
      target = price_target.where(:min_qty => total_quantity).first
    elsif total_quantity > 100 && total_quantity <= 1000 #get range
      if total_quantity % 100 == 0
        max = total_quantity
        min = total_quantity - 99
      else
        min = ((total_quantity/100) * 100) + 1
        max = (total_quantity/100 + 1) * 100
      end
      target = price_target.where(:min_qty => min, :max_qty => max).first
    else
      target = price_target.where("min_qty > 1000").first
    end   
    target
  end
end
