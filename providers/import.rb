include CobblerReader

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

# Imports a new distro if doesn't exist already
action :import do
  if get_distro(new_resource.name)
    Chef::Log.debug("#{new_resource.name} is already imported")
  else
    converge_by("importing #{new_resource.name} into cobbler") do
      perform_image_import
    end
  end
end

# TODO: Add all the options here
def _import_cmd(mount_point)
  cmd = []
  cmd << "cobbler import --name='#{new_resource.name}'"
  cmd << "--path=#{mount_point}"
  cmd << "--breed=#{new_resource.os_breed}" if new_resource.os_breed
  cmd << "--arch=#{new_resource.os_arch}" if new_resource.os_arch
  cmd << "--os-version=#{new_resource.os_version}" if new_resource.os_version
  cmd << "--available-as=#{new_resource.available_as}" if new_resource.available_as
  cmd.join(' ')
end

private

def perform_mount(target_iso, mount_point)
  # Mount the ISO file
  mount "#{new_resource.name}-mount-iso" do
    mount_point mount_point
    device target_iso
    options 'loop'
    fstype 'iso9660'
    options %w(loop ro)
    action :mount
    only_if { ::File.exist? target_iso }
  end
end

def perform_image_import
  mount_point = ::File.join(Chef::Config[:file_cache_path], 'mnt')
  iso_name = "#{new_resource.name}#{::File.extname(new_resource.source)}"
  target_iso = ::File.join(Chef::Config[:file_cache_path], iso_name)

  # Create the directory where iso should be mounted
  directory "#{new_resource.name}-mount_point" do
    path mount_point
    action :create
  end

  # The DVD(iso) file can be http or ftp location or can be local file
  # The ISO file is downloaded in a temporary location
  remote_file "#{new_resource.name}-iso_file" do
    path target_iso
    source new_resource.source
    checksum new_resource.checksum
  end

  perform_mount(target_iso, mount_point)

  # Perform the actual import, which copies the mounted content from tmp location
  # to a location where apache can serve it over http
  # Makes sure to umount and delete the ISO and remove the temporary dir
  execute "#{new_resource.name}-cobbler-import" do
    command _import_cmd(mount_point)
    notifies :umount, "mount[#{new_resource.name}-mount-iso]", :immediate
    notifies :delete, "directory[#{new_resource.name}-mount_point]", :delayed
    notifies :delete, "remote_file[#{new_resource.name}-iso_file]", :immediate
    # notifies :run, 'bash[cobbler-sync]', :delayed
    # not_if "cobbler distro report --name #{distro_name}"
  end
end
