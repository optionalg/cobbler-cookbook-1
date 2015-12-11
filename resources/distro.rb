actions :update, :delete
default_action :update

attribute :name, kind_of: String, required: true

attribute :initrd, kind_of: String
attribute :initrd_checksum, String  # TODO: check if its a good idea

attribute :kernel, kind_of: String
attribute :kernel_checksum, kind_of: String # TODO: check if its a good idea

attribute :os_version, kind_of: String
attribute :kopts, kind_of: String
attribute :kopts_post, kind_of: String
attribute :ksmeta, kind_of: String

# TODO: They can take only (choose from 'i386', 'x86_64', 'ia64', 'ppc', 'ppc64',
# 's390', 'arm') [--breed=redhat|debian|suse]
attribute :os_arch, kind_of: String
attribute :os_breed, kind_of: String
attribute :template, kind_of: String

# TODO: if add initrd and kernel are 'Required true'
# If edit many are not required
# If import path is 'required true'

# TODO: while updating options there make sure to update providers/distro.rb if conditions
