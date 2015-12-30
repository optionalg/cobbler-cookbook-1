actions :update, :delete
default_action :update

attribute :name, kind_of: String, required: true
attribute :distro, kind_of: String
attribute :kickstart, kind_of: String
attribute :repos, kind_of: Array
