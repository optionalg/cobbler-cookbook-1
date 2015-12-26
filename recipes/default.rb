#
# Cookbook Name:: cobbler
# Recipe:: default
#
# Copyright (C) 2015 Altiscale, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cobbler::xinetd'
include_recipe 'cobbler::apache'

conf_dir = node[:cobbler][:conf_dir]
cobbler_service = node[:cobbler][:service_name]

package 'syslinux'
package 'cobbler'

template "#{conf_dir}/settings" do
  source 'cobbler-settings.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{cobbler_service}]"
end

template "#{conf_dir}/modules.conf" do
  source 'cobbler-modules.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{cobbler_service}]"
end

service cobbler_service do
  service_name 'cobblerd'
  action [:enable, :start]
end

service 'httpd' do
  action :restart
end
