actions :update, :delete
default_action :update

attribute :name, kind_of: String, required: true
attribute :mirror, kind_of: String
attribute :keep_updated, kind_of: [TrueClass, FalseClass], default: true
attribute :priority, kind_of: Integer
attribute :arch, kind_of: String
attribute :breed, kind_of: String
