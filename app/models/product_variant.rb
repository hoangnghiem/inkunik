class ProductVariant < ActiveRecord::Base
  belongs_to :product, :counter_cache => :product_variants_count
  validates :sku, :uniqueness => true, :presence => true
  acts_as_list :scope => :product

  before_save :tokenize_colors

  def color_list
    return self.colors.split('|') unless colors.blank?
    []
  end

  def tokenize_colors
    if !self.colors.blank?
      self.colors = self.colors.join('|') if self.colors.kind_of?(Array)
    else
      self.colors = nil
    end
  end
end
