actions :import
default_action :import

attribute :name, kind_of: String, required: true
attribute :source, kind_of: String, required: true
attribute :os_breed, kind_of: String
attribute :os_arch, kind_of: String
attribute :checksum, kind_of: String
attribute :available_as, kind_of: String
attribute :os_version, kind_of: String
