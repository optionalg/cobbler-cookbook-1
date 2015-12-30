
# Install and setup cobbler first
include_recipe 'cobbler'

# We create a temporary vmlinuz and initrd for the sake of testing from /boot
# of the VM on which testing is doen.

# This is valid only for kitchen testing
remote_file 'vmlinuz_for_kitchen' do
  path '/var/tmp/vmlinuz'
  source "file://#{Dir['/boot/vmlinuz*'][0]}"
end

remote_file 'initrd_for_kitchen' do
  path '/var/tmp/initrd'
  source "file://#{Dir['/boot/initramfs*'][0]}"
end

cobbler_repo 'epel' do
  mirror 'https://dl.fedoraproject.org/pub/epel/6/x86_64/'
  keep_updated true
  priority 99
  arch 'x86_64'
  breed 'yum'
end

cobbler_distro 'sampledistro' do
  initrd 'file:///var/tmp/initrd'
  kernel 'file:///var/tmp/vmlinuz'
  os_arch 'x86_64'
end

ks_cfg = '/var/lib/cobbler/kickstarts/kickstart.cfg'

kickstart_cfg File.basename(ks_cfg) do
  root_password 'joker'
  timezone 'IST'
end

cobbler_profile 'sampleprofile' do
  distro 'sampledistro'
  kickstart ks_cfg
  repos ['epel']
end
