
define :kickstart_cfg, template: 'kickstart.cfg.erb' do
  ks_path = "#{node[:cobbler][:path]}/kickstarts"
  ks_file = "#{ks_path}/#{params[:name]}"

  directory ks_path do
    owner 'root'
    group 'root'
    action :create
    recursive true
  end

  template ks_file do
    source 'kickstart.cfg.erb'
    owner 'root'
    group 'root'
    mode 0644
    cookbook params[:cookbook] if params[:cookbook]
    variables(
      params: params
    )
  end
end
