class Site < ActiveRecord::Base

  CURRENT_SITE = "current_site"

  # RELATIONSHIP
  # ---------------------------------------
  has_many :categories, :dependent => :destroy

  class << self
    def get_site(domain)
      site = Site.find_by_domain(domain)
      raise Exception, "Site '#{domain}' is not configured" if site.nil?
      site
    end
  end
end
