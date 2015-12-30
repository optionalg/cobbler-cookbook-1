# encoding: UTF-8
require 'spec_helper'

describe 'cobbler::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new do # |node|
    end.converge(described_recipe)
  end

  it 'should converge' do
    expect(chef_run).to include_recipe(described_recipe)
  end

  before do
    stub_command('/usr/sbin/httpd -t').and_return(0)
  end

  it 'should create tftpboot' do
    expect(chef_run).to create_directory('/var/lib/tftpboot')
  end

  it 'should create cookbook file menu.c32' do
    expect(chef_run).to create_cookbook_file('/var/lib/tftpboot/menu.c32')
  end

  it 'should create cookbook file pxelinux.0' do
    expect(chef_run).to create_cookbook_file('/var/lib/tftpboot/pxelinux.0')
  end

  it 'should install syslinux' do
    expect(chef_run).to install_package('syslinux')
  end

  it 'should install package cobbler' do
    expect(chef_run).to install_package('cobbler')
  end

  it 'should create file /etc/cobbler/settings' do
    expect(chef_run).to create_file('/etc/cobbler/settings')
  end

  it 'should create template /etc/cobbler/modules.conf' do
    expect(chef_run).to create_template('/etc/cobbler/modules.conf')
  end

  it 'should start cobblerd service' do
    expect(chef_run).to start_service('cobblerd')
  end

  it 'should restart httpd' do
    expect(chef_run).to start_service('httpd')
  end
end
