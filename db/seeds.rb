# CREATE PERMISSIONS
# -----------------------------------------------
perms = ['read', 'create', 'update', 'destroy', 'manage']
objects = ['Admin', 'Role', 'Category', 'Product']
model_perms = []
perms.each do |p|
  objects.each do |o|
    model_perms << { :action => p, :object_type => o, :name => "Manage #{o}" }
  end
end

non_model = []
non_model << { :action => 'read', :object_type => 'Dashboard', :name => "Dashboard", :model => false }
arr = model_perms.concat(non_model)
permissions = Permission.create!(arr)

# CREATE USER AND ROLE
# -----------------------------------------------
role_super_admin = Role.create!(:name => Role::SUPER_ADMIN)
role_super_admin.admins.create!(:username => 'admin', :email => "admin@inkunik.com", :password => "123qwe")
role_super_admin.admins.create!(:username => 'hnghiem', :email => "hoangnghiem1711@gmail.com", :password => "123123")

# CREATE SITES
# -----------------------------------------------
vn_site = Site.create!(
  :site_code => "VN", 
  :domain => APP_CONFIG['site']['vn_domain'], 
  :locale => "vi", 
  :currency_code => "VND", 
  :currency_symbol => I18n.translate('site.currency_symbol', :locale => 'vi'),
  :default => true
)
en_site = Site.create!(
  :site_code => "EN", 
  :domain => APP_CONFIG['site']['en_domain'], 
  :locale => "en", 
  :currency_code => "USD", 
  :currency_symbol => "$", 
  :default => false
)

# IMPORT CATALOG
# -----------------------------------------------
DataImporter.import_all("0AhLXGu9VJbFTdHBBdU9senJIQVc4dWpIbU0zR0ZuTkE", "inkunikdev", "inkunik1!")
Product.all.each do |p|
  Product.update_counters p.id, :product_variants_count => p.product_variants.length
  p.product_variants.each_with_index do |pv, idx|
    pv.position = idx + 1
    pv.save!
  end
end
