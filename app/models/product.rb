class Product < ActiveRecord::Base
  # RELATION SHIP
  # ------------------------------
  has_many :product_category_relations, :dependent => :destroy
  has_many :categories, :through => :product_category_relations
  has_many :product_variants, :dependent => :destroy
  accepts_nested_attributes_for :product_variants, :reject_if => lambda { |a| a[:sku].blank? },:allow_destroy => true

  # VALIDATION
  # ------------------------------
  validates :slug, :uniqueness => true, :presence => true
  validates :name, :uniqueness => true, :presence => true

  # NAMED SCOPE
  # ------------------------------
  scope :active, where(:active => true)

  # CONSTANTS
  # ------------------------------
  FABRICS = %w{ cotton_pe cotton_6535_mong cotton_6535_day casau_pe casau_6535_4chieu_dam casau_6535_4chieu_nhat casau_100_cotton_4chieu camap_pe camap_6535_mong camap_6535_day }

  COLOR_NAMES = [
    'Light Blue','Blue Jean','Turqoise','Royal Blue','Navy',
    'Mint','Sagestone','Jade','Kelly Green','Olive Green',
    'Cream','Sand','Khaki','Brown','Army Green',
    'White','Silver Grey','Heatherish','Dark Grey','Black',
    'Fuchsia','Red','Maroon','Purple','Eggplant',
    'Pink','Lemon','Banana','Gold','Orange'
  ]

  INK_TYPES = {
    :ink => 'ink',
    :embroidery => 'embroidery'
  }

  def to_param
    return "#{id}-#{slug}" unless slug.blank?
    super
  end

  def default_variant
    product_variants.where(:default => true).first
  end

end
