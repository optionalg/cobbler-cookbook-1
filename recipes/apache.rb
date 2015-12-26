include_recipe 'apache2'

include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_wsgi'

# Ensure the apache default site is disabled.
apache_site '000-default' do
  enable false
end

# Create the site cobbler using, its wrapped with <virtual
web_app 'cobbler' do
  template 'cobbler-httpd.erb'  
end
