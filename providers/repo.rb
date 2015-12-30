include CobblerReader

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :delete do
  if get_repo(new_resource.name)
    converge_by("Repo #{new_resource.name} removing from cobbler") do
      execute "#{new_resource.name}-yum-repo-delete" do
        command "cobbler repo remove --name=#{new_resource.name}"
      end
    end
  else
    Chef::Log.debug("Repo #{new_resource.name} is dead already")
  end
end

action :update do
  repo = get_repo(new_resource.name)

  # If repo exists update it else create new
  if repo
    if repo_updated?(repo)
      Chef::Log.debug("Repo #{new_resource.name} is already updated")
    else
      perform_repo('edit')
    end
  else
    perform_repo('add')
  end
end

private

def repo_updated?(repo)
  return false unless new_resource.mirror == repo['mirror']
  return false unless new_resource.keep_updated == repo['keep_updated']
  return false unless new_resource.arch == repo['arch']
  return false unless new_resource.breed == repo['breed']
  return true
end

def generate_cmd(action)
  keep_updated = new_resource.keep_updated
  cmd = []
  cmd << "cobbler repo #{action} --name=#{new_resource.name}"
  cmd << "--mirror=#{new_resource.mirror}" if new_resource.mirror
  cmd << "--keep-updated=#{keep_updated}" if keep_updated
  cmd << "--priority=#{new_resource.priority}" if new_resource.priority
  cmd << "--arch=#{new_resource.arch}" if new_resource.arch
  cmd << "--breed=#{new_resource.breed}" if new_resource.breed
  cmd.join(' ')
end

def perform_repo(action)
  repo_update_cmd = generate_cmd(action)
  execute "#{new_resource.name}-repo-update" do
    command repo_update_cmd
  end
  new_resource.updated_by_last_action(true)
end
