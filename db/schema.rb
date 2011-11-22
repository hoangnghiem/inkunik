# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101215025053) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["username"], :name => "index_admins_on_username", :unique => true

  create_table "categories", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.integer  "position"
    t.integer  "parent_id",            :default => -1
    t.string   "slug"
    t.string   "path"
    t.integer  "sub_categories_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_item_options", :force => true do |t|
    t.integer  "design_item_id"
    t.string   "garment_size_name"
    t.string   "garment_color_name"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_items", :force => true do |t|
    t.integer  "product_variant_id"
    t.integer  "design_id"
    t.string   "ink_type"
    t.text     "front_design"
    t.text     "back_design"
    t.text     "left_design"
    t.text     "right_design"
    t.integer  "num_of_color"
    t.integer  "num_of_photo"
    t.integer  "num_of_location"
    t.integer  "total_quantity"
    t.float    "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designs", :force => true do |t|
    t.integer  "product_variant_id"
    t.string   "ink_type"
    t.text     "canvas_data"
    t.text     "front_design"
    t.text     "back_design"
    t.text     "left_design"
    t.text     "right_design"
    t.string   "design_name"
    t.integer  "num_of_color"
    t.integer  "num_of_photo"
    t.integer  "num_of_location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "embroidery_prices", :force => true do |t|
    t.integer  "site_id"
    t.integer  "min_qty"
    t.integer  "max_qty"
    t.float    "location1"
    t.float    "location2"
    t.float    "location3"
    t.float    "location4"
    t.float    "location5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ink_prices", :force => true do |t|
    t.integer  "site_id"
    t.integer  "min_qty"
    t.integer  "max_qty"
    t.float    "color1"
    t.float    "color2"
    t.float    "color3"
    t.float    "color4"
    t.float    "color5"
    t.float    "color6"
    t.float    "color7"
    t.float    "color8"
    t.float    "color9"
    t.float    "color10"
    t.float    "color11"
    t.float    "color12"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "design_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", :force => true do |t|
    t.string   "order_status_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "billing_firstname"
    t.string   "billing_lastname"
    t.string   "billing_address"
    t.string   "billing_country"
    t.string   "billing_state"
    t.string   "billing_zipcode"
    t.string   "billing_phone"
    t.string   "shipping_firstname"
    t.string   "shipping_lastname"
    t.string   "shipping_address"
    t.string   "shipping_state"
    t.string   "shipping_country"
    t.string   "shipping_zipcode"
    t.string   "shipping_phone"
    t.integer  "shipping_method_id"
    t.float    "order_sub_total"
    t.float    "shipping_fee"
    t.float    "tax_fee"
    t.string   "promotion_code"
    t.float    "discount_amount"
    t.float    "order_total"
    t.integer  "order_status"
    t.datetime "requested_date"
    t.datetime "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "action"
    t.string   "object_type"
    t.boolean  "model",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_category_relations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_variants", :force => true do |t|
    t.string   "sku"
    t.integer  "product_id"
    t.string   "fabric"
    t.integer  "min_order_qty",     :default => 0
    t.float    "price"
    t.float    "blank_shirt_price"
    t.boolean  "active",            :default => true
    t.boolean  "default"
    t.string   "colors"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "printable"
    t.boolean  "embroiderable"
    t.string   "slug"
    t.boolean  "active",                 :default => true
    t.integer  "product_variants_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_permissions", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_methods", :force => true do |t|
    t.string   "shipping_method_name"
    t.string   "unit"
    t.float    "shipping_rate"
    t.string   "active_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.string   "site_code"
    t.string   "locale"
    t.string   "currency_code"
    t.string   "currency_symbol"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upload_photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "full_name"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
