class Category < ActiveRecord::Base
  # RELATIONSHIP
  # ----------------------------------------
  has_many :sub_categories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent, :class_name => "Category", :counter_cache => :sub_categories_count
  belongs_to :site
  acts_as_list :scope => :parent
  has_many :product_category_relations
  has_many :products, :through => :product_category_relations

  # VALIDATION
  # ----------------------------------------
  validates :path, :uniqueness => true, :presence => true
  validates :name, :presence => true

  def to_param
    return "#{id}-#{slug}" unless slug.blank?
    super
  end

  def parent?
    self.parent_id == -1
  end

  def child?
    self.parent_id != -1
  end

  def move_up?
    self.position > 1 
  end

  def move_down?
    last_pos = Category.count(:conditions => "parent_id == #{self.parent_id}")
    self.position != last_pos
  end
end
