class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :set_current_site, :get_session_id
  
  def current_domain
    unless request.subdomains.blank?
      request.subdomains.join(".") << "." << request.domain
    else
      request.domain
    end
  end

  protected
  def set_current_site
    if session[:site_domain].blank?
      site = Site.get_site(current_domain)
      session[:site_domain] = site.domain
      session[:locale] = site.locale
      session[:site_code] = site.site_code
    else
      if session[:site_domain] != current_domain
        site = Site.get_site(current_domain)
        session[:site_domain] = site.domain
        session[:locale] = site.locale
        session[:site_code] = site.site_code
      end
    end
    # update locale
    current_locale = I18n.available_locales.include?(session[:locale].to_sym) ? session[:locale] : nil
    I18n.locale = current_locale
  end

  def get_session_id
    @session_id = request.session_options[:id]
    @session_id = session[:session_id]
    @session_id = request.session_options[:id]
  end
end
