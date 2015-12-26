include CobblerReader

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

# Deletes a distro if exists already, if there is a depending profile cobbler
# throws error not handled here
action :delete do
  if get_distro(new_resource.name)
    converge_by("delete #{new_resource.name} from cobbler") do
      execute "#{new_resource.name}-distro-delete" do
        command "cobbler distro remove --name=#{new_resource.name}"
      end
    end
  else
    Chef::Log.debug("Distro #{new_resource.name} is dead already")
  end
end

# 'cobbler distro add' and 'cobbler distro edit' together
action :update do
  distro = get_distro(new_resource.name)
  if distro
    if distro_updated?(distro)
      Chef::Log.debug("Distro #{new_resource.name} is already updated")
    else
      perform_distro('edit')
    end
  else
    perform_distro('add')
  end
end

private

def distro_updated?(distro)
  # TODO: Check the checksum kernel and initrd
  return false unless new_resource.os_arch == distro['arch'] if new_resource.os_arch
  # return false unless new_resource.kopts == distro['kernel_options'] if new_resource.kopts
  return false unless new_resource.kopts_post == distro['kernel_options_post'] \
    if new_resource.kopts_post
  # return false unless new_resource.os_breed == distro['breed'] if new_resource.os_breed
  # return false unless new_resource.os_version == distro['os_version'] if new_resource.os_version
  return true
end

def distro_resources_path
  ::File.join(node[:cobbler][:path], "distros/#{new_resource.name}")
end

# The user may specify their custom initrd path or kernel path which cobbler
# distro should updated. This func puts the initrd file and returns its location
# to be used in 'cobbler distro edit'
def initrd_setup
  initrd_path = ::File.join("#{distro_resources_path}/initrd") # TODO: !initrd
  remote_file "#{new_resource.initrd}-initrd_file" do
    path initrd_path
    source new_resource.initrd
  end
  "--initrd=#{initrd_path}"
end

def kernel_setup
  kernel_path = ::File.join("#{distro_resources_path}/vmlinuz") # TODO: !vmlinuz
  remote_file "#{new_resource.initrd}-initrd_file" do
    path kernel_path
    source new_resource.initrd
  end
  "--kernel=#{kernel_path}"
end

def generate_cmd(action)
  # TODO: Add all the options here
  cmd = []
  cmd << "cobbler distro #{action} --name=#{new_resource.name}"
  cmd << kernel_setup if new_resource.kernel
  cmd << initrd_setup if new_resource.initrd
  cmd << "--breed=#{new_resource.os_breed}" if new_resource.os_breed
  cmd << "--arch=#{new_resource.os_arch}" if new_resource.os_arch
  cmd.join(' ')
end

def perform_distro(action)
  directory distro_resources_path do
    recursive true
  end

  distro_update_cmd = generate_cmd(action)
  Chef::Log.debug(distro_update_cmd)
  execute "#{new_resource.name}-distro-update" do
    command distro_update_cmd
  end
  new_resource.updated_by_last_action(true)
end
