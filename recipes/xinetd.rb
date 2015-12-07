
include_recipe 'xinetd'

# TFTP
directory node[:cobbler][:tftp_path] do
  action :create
  owner 'root'
  group 'root'
end

xinetd_service 'tftp' do
  action :enable
  socket_type 'dgram'
  protocol 'udp'
  wait true
  user 'root'
  server '/usr/sbin/in.tftpd'
  server_args "#{node[:cobbler][:tftp_options]} #{node[:cobbler][:tftp_path]}"
  per_source '11'
  cps '100 2'
  flags 'IPv4'
end

%w(menu.c32 pxelinux.0).each do | pxfile |
  tftp_path = node[:cobbler][:tftp_path]
  cookbook_file "#{tftp_path}/#{pxfile}" do
    source pxfile
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end
