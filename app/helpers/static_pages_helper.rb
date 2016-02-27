require 'resolv'

module StaticPagesHelper
  def resolv_domain(domain)
    Resolv.getaddresses domain
  end
end
