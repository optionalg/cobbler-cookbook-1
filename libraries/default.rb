require 'xmlrpc/client'

# Module that queries cobbler
module CobblerReader
  def get_distro(distro_name)
    cobbler_search_name('get_distros', distro_name)
  end

  def get_profile(profile_name)
    cobbler_search_name('get_profiles', profile_name)
  end

  def get_system(system_name)
    cobbler_search_name('get_systems', system_name)
  end

  private

  def cobbler_search_name(cobbler_method, search_item_name)
    items = connection.call(cobbler_method)
    items.each do | item |
      next unless item['name'] == search_item_name
      return item
    end
    return false
  end

  def connection
    # TODO: Remove this hardcoding
    cobbler_host = '127.0.0.1'
    XMLRPC::Client.new2("http://#{cobbler_host}/cobbler_api", nil, 30)
  end
end
