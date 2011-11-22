module ApplicationHelper

  # mark required field
  def required
    content_tag :span, " *", :class => 'required'
  end

  # insert page title
  def title(page_title)
    content_for(:title) { page_title }
  end

  # retrieve the current site
  def current_site
    @current_site = Rails.cache.read(Site::CURRENT_SITE)
    if @current_site.nil?
      @current_site = Site.get_site(session[:site_domain])
      Rails.cache.write(Site::CURRENT_SITE, @current_site)
    else
      if @current_site.domain != session[:site_domain]
        @current_site = Site.get_site(session[:site_domain])
        Rails.cache.write(Site::CURRENT_SITE, @current_site)
      end
    end
    @current_site
  end

  # format the money
  def format_money(price, site)
    pres = 2
    pres = 0 if site.currency_code == "VND"  
    number_to_currency(price, :unit => site.currency_symbol, :precision => pres, :format => "%n %u")
  end

  def format_comma_number(price)
    price.to_i.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')
  end

  # get current domain
  def current_domain
    request.subdomains.join(".") << "." << request.domain
  end

  def link_to_remove_fields(name, f)  
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")  
  end 

  def link_to_add_fields(name, f, association)  
    new_object = f.object.class.reflect_on_association(association).klass.new  
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
      render(association.to_s.singularize + "_fields", :f => builder)  
    end  
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")  
  end
end
