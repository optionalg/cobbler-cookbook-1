include CobblerReader

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :delete do
  if get_profile(new_resource.name)
    converge_by("Profile #{new_resource.name} removing from cobbler") do
      execute "#{new_resource.name}-profile-delete" do
        command "cobbler profile remove --name=#{new_resource.name}"
      end
    end
  else
    Chef::Log.debug("Profile #{new_resource.name} is dead already")
  end
end

# 'cobbler profile add' and 'cobbler profile edit' together
action :update do
  profile = get_profile(new_resource.name)
  if profile
    if profile_updated?(profile)
      Chef::Log.debug("Profile #{new_resource.name} is already updated")
    else
      perform_profile('edit')
    end
  else
    perform_profile('add')
  end
end

private

def profile_updated?(profile)
  # TODO: Check the checksum kernel and initrd
  # return false unless profile  # Return false if the distro doesn't exist at all
  return false unless new_resource.name == profile['name']
  return false unless new_resource.distro == profile['distro']
  # TODO: kickstart checksum compare
  return false unless new_resource.kickstart == profile['kickstart'] if new_resource.kickstart
  return true
end

def generate_cmd(action)
  cmd = []
  cmd << "cobbler profile #{action} --name=#{new_resource.name}"
  cmd << "--kickstart=#{new_resource.kickstart}" if new_resource.kickstart
  cmd << "--distro=#{new_resource.distro}" if new_resource.distro
  cmd.join(' ')
end

def perform_profile(action)
  profile_update_cmd = generate_cmd(action)
  execute "#{new_resource.name}-profile-update" do
    command profile_update_cmd
  end
  new_resource.updated_by_last_action(true)
end
