require 'rubygems'
require 'google_spreadsheet'

module DataImporter
  PRODUCT_FIELDS = {
    :name => 1,
    :slug => 2,
    :description => 3,
    :printable => 4,
    :embroiderable => 5
  }

  VARIANT_FIELDS = {
    :sku => 1,
    :product_slug => 2,
    :fabric => 3,
    :min_order_qty => 4,
    :price => 5,
    :blank_shirt_price => 6,
    :default => 7,
    :colors => 8
  }

  CATEGORY_FIELDS = {
    :level1 => 1,
    :level2 => 2,
    :level3 => 3,
    :seo => 4,
    :path => 5
  }

  RELATION_FIELDS = {
    :category_path => 1,
    :product_slug => 2
  }

  SHEETS = {
    :men_product => 0,
    :women_product => 1,
    :men_variant => 2,
    :women_variant => 3,
    :men_category => 4,
    :women_category => 5,
    :men_relation => 6,
    :women_relation => 7,
    :ink_prices => 8,
    :embroid_prices => 9
  }
  
  def self.import_all(worksheet_key, gusername, gpassword)
    ws = self.get_worksheet(worksheet_key, gusername, gpassword)
    self.import_product(SHEETS[:men_product], ws)
    self.import_product(SHEETS[:women_product], ws)
    self.import_variant(SHEETS[:men_variant], ws)
    self.import_variant(SHEETS[:women_variant], ws)
    self.import_category(SHEETS[:men_category], ws)
    self.import_category(SHEETS[:women_category], ws)
    self.import_relation(SHEETS[:men_relation], ws)
    self.import_relation(SHEETS[:women_relation], ws)
    GoogleSpreadsheetImporter.import_sheet(InkPrice, ws, SHEETS[:ink_prices])
    GoogleSpreadsheetImporter.import_sheet(EmbroideryPrice, ws, SHEETS[:embroid_prices])
  end

  def self.get_worksheet(worksheet_key, gusername, gpassword)
    session = GoogleSpreadsheet.login(gusername, gpassword)
    ws = session.spreadsheet_by_key(worksheet_key).worksheets
    raise "Spreadsheet with key #{worksheet_key} not found" if ws.nil?
    ws
  end

  def self.import_product(sheet_index, worksheets)
    ws = worksheets[sheet_index]
    puts "[START] ----- Import Product from sheet '#{ws.title}' -----"
    products = []
    for row in 2..ws.num_rows
      unless ws[row,1].blank?
        product = Product.new(
          :name              => ws[row, PRODUCT_FIELDS[:name]],
          :description       => ws[row, PRODUCT_FIELDS[:description]],
          :printable         => ActiveRecord::ConnectionAdapters::Column.value_to_boolean(ws[row, PRODUCT_FIELDS[:printable]]),
          :embroiderable     => ActiveRecord::ConnectionAdapters::Column.value_to_boolean(ws[row, PRODUCT_FIELDS[:embroiderable]]),
          :slug              => ws[row, PRODUCT_FIELDS[:slug]]
        )
        products << product
        puts "Importing product: #{product.name}"
      end
    end
    Product.import products, :validate => true, :on_duplicate_key_update => [:name]
    puts "[END] ----- Import Product -----"
  end

  def self.import_variant(sheet_index, worksheets)
    ws = worksheets[sheet_index]
    puts "[START] ----- Import Variant from sheet '#{ws.title}' -----"

    variants = []
    products = Hash[*Product.all(:select => [:id, :slug]).collect {|p| [p.slug, p.id]}.flatten]
    for row in 2..ws.num_rows
      unless ws[row,1].blank?
        variant = ProductVariant.new(
          :sku => ws[row, VARIANT_FIELDS[:sku]],
          :product_id => products[ws[row, VARIANT_FIELDS[:product_slug]]],
          :fabric => ws[row, VARIANT_FIELDS[:fabric]],
          :min_order_qty => ws[row, VARIANT_FIELDS[:min_order_qty]],
          :price => ws[row, VARIANT_FIELDS[:price]],
          :blank_shirt_price => ws[row, VARIANT_FIELDS[:blank_shirt_price]],
          :default => ActiveRecord::ConnectionAdapters::Column.value_to_boolean(ws[row, VARIANT_FIELDS[:default]]),
          :colors => ws[row, VARIANT_FIELDS[:colors]]
        )
        variants << variant 
        puts "Importing sku: #{variant.sku} for product '#{products[ws[row, VARIANT_FIELDS[:product_slug]]]}'"
      end
    end
    ProductVariant.import variants, :validate => true, :on_duplicate_key_update => [:sku]
    puts "[END] ----- Import Variant -----"
  end

  def self.import_category(sheet_index, worksheets)
    ws = worksheets[sheet_index]
    puts "[START] ----- Import Category from sheet '#{ws.title}' -----"
    site_code = ws.title.split("_")
    site = Site.find_by_site_code(site_code)

    current_level_1 = nil
    current_level_2 = nil
    current_level_3 = nil

    for row in 2..ws.num_rows
      unless ws[row, CATEGORY_FIELDS[:level1]].blank?
        current_level_1 = Category.create!({
          :site_id => site.id,
          :parent_id => -1,
          :name => ws[row, CATEGORY_FIELDS[:level1]],
          :path => ws[row, CATEGORY_FIELDS[:path]],
          :slug => ws[row, CATEGORY_FIELDS[:seo]]
        })
        puts "level 1 #{current_level_1.name}"
      end

      unless ws[row, CATEGORY_FIELDS[:level2]].blank?
        current_level_2 = Category.create!({
          :site_id => site.id,
          :parent_id => current_level_1.id,
          :name => ws[row, CATEGORY_FIELDS[:level2]],
          :path => ws[row, CATEGORY_FIELDS[:path]],
          :slug => ws[row, CATEGORY_FIELDS[:seo]]
        })

        puts "level 2 #{current_level_2.name}"
      end

      unless ws[row, CATEGORY_FIELDS[:level3]].blank?
        current_level_3 = Category.create!({
          :site_id => site.id,
          :parent_id => current_level_2.id,
          :name => ws[row, CATEGORY_FIELDS[:level3]],
          :path => ws[row, CATEGORY_FIELDS[:path]],
          :slug => ws[row, CATEGORY_FIELDS[:seo]]
        })

        puts "level 3 #{current_level_3.name}"
      end
    end   
    puts "[END] ----- Import Category -----"
  end

  def self.import_relation(sheet_index, worksheets)
    ws = worksheets[sheet_index]
    puts "[START] ----- Import Relation from sheet '#{ws.title}' -----"
    columns = [:category_id, :product_id]
      values = []

    for row in 2..ws.num_rows
      unless ws[row,1].blank?
        category_id = Category.find_by_path(ws[row, RELATION_FIELDS[:category_path]]).id
        product_id = Product.find_by_slug(ws[row, RELATION_FIELDS[:product_slug]]).id
        values << [category_id, product_id]
      end
    end   

    ProductCategoryRelation.import columns, values
    puts "[END] ----- Import Relation -----"
  end

end
