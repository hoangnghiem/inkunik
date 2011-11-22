class QuoteValidator < ActiveModel::Validator

  def validate(record)
    if record.ink?
      if record.num_of_colors.blank? || !is_numeric?(record.num_of_colors) || !(1..99).include?(record.num_of_colors.to_i)
        record.errors[:num_of_colors] << I18n.t('activemodel.errors.messages.num_of_colors')
      end
    else
      unless (1..5).include?(record.num_of_locations.to_i)
        record.errors[:num_of_locations] << I18n.t('activemodel.errors.messages.num_of_locations')
      end
    end

    if record.quantities.blank?
      record.errors[:quantities] << I18n.t('activemodel.errors.messages.quantities.blank')
    else
      qties = record.quantities.values.select {|qty| !qty.blank?}
      if qties.blank?
        record.errors[:quantities] << I18n.t('activemodel.errors.messages.quantities.blank')
      else
        valid = true 
        qties.each do |qty|
          unless is_numeric?(qty)
            record.errors[:quantities] << I18n.t('activemodel.errors.messages.quantities.not_a_number')
            valid = false
            break
          end
        end
        if valid && record.total_quantity < record.product_variant.min_order_qty
          record.errors[:quantities] << I18n.t('activemodel.errors.messages.quantities.min_qty', :min_qty => record.product_variant.min_order_qty)
        end
      end
    end
  end

  def is_numeric?(string)
    begin
      Integer(string).is_a?(Integer)
    rescue
      false
    end
  end

end
