actions :update, :delete
default_action :update

attribute :name, kind_of: String, required: true
attribute :profile, kind_of: String
attribute :mac, kind_of: String
attribute :ip_address, kind_of: String
attribute :hostname, kind_of: String
attribute :netboot, kind_of: [TrueClass, FalseClass], default: false
attribute :kopts, kind_of: String
attribute :ksmeta, kind_of: String
attribute :kickstart, kind_of: String
attribute :static_routes, kind_of: String

# oob related options
attribute :oob_address, kind_of: String
attribute :oob_type, kind_of: String
attribute :oob_user, kind_of: String
attribute :oob_password, kind_of: String
attribute :oob_id, kind_of: String
