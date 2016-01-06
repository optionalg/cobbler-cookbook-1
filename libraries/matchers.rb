# TODO: Add for delete also
if defined?(ChefSpec)
  def update_cobbler_repo(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cobbler_repo, :update, resource_name)
  end

  def import_cobbler_import(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cobbler_import, :import, resource_name)
  end

  def update_cobbler_distro(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cobbler_distro, :update, resource_name)
  end

  def update_cobbler_profile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cobbler_profile, :update, resource_name)
  end
end
