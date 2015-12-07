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

# TODO: This needs to use yum repo
remote_file '/var/tmp/cobbler.rpm' do
  source 'http://download.opensuse.org/repositories/home:/libertas-ict:/cobbler26/CentOS_CentOS-6/noarch/cobbler-2.6.10-11.1.noarch.rpm'
  action :create_if_missing
end

package 'cobbler' do
  version '2.6.10'
  source '/var/tmp/cobbler.rpm'
end

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
