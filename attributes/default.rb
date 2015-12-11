default[:cobbler][:conf_dir] = '/etc/cobbler'
default[:cobbler][:service_name] = 'cobblerd'

# TFTP
default[:cobbler][:tftp_path] = '/var/lib/tftpboot'
default[:cobbler][:tftp_options] = '-B 1380 -v -s'

# Apache configurations
default[:cobbler][:path] = '/var/lib/cobbler'
default[:cobbler][:docroot] = '/var/www/cobbler'
default[:cobbler][:web][:root] = '/var/www/cobbler/web'

# XMLRPC parameters
default[:cobbler][:xmlrpc_hostname] = '127.0.0.1'
default[:cobbler][:hostname] = ''
default[:cobbler][:password] = ''
default[:cobbler][:secure] = false
default[:cobbler][:timeout] = 30
