# Configurations to configure /etc/cobbler/modules.conf

# authentication:
# what users can log into the WebUI and Read-Write XMLRPC?
# choices:
#    authn_denyall    -- no one (default)
#    authn_configfile -- use /etc/cobbler/users.digest (for basic setups)
#    authn_passthru   -- ask Apache to handle it (used for kerberos)
#    authn_ldap       -- authenticate against LDAP
#    authn_spacewalk  -- ask Spacewalk/Satellite (experimental)
#    authn_pam        -- use PAM facilities
#    authn_testing    -- username/password is always testing/testing (debug)
#    (user supplied)  -- you may write your own module
# WARNING: this is a security setting, do not choose an option blindly.
# for more information:
# https://github.com/cobbler/cobbler/wiki/Cobbler-web-interface
# https://github.com/cobbler/cobbler/wiki/Security-overview
# https://github.com/cobbler/cobbler/wiki/Kerberos
# https://github.com/cobbler/cobbler/wiki/Ldap
default[:cobbler][:module][:authentication] = 'authn_denyall'

# authorization:
# once a user has been cleared by the WebUI/XMLRPC, what can they do?
# choices:
#    authz_allowall   -- full access for all authneticated users (default)
#    authz_ownership  -- use users.conf, but add object ownership semantics
#    (user supplied)  -- you may write your own module
# WARNING: this is a security setting, do not choose an option blindly.
# If you want to further restrict cobbler with ACLs for various groups,
# pick authz_ownership.  authz_allowall does not support ACLs.  configfile
# does but does not support object ownership which is useful as an additional
# layer of control.
default[:cobbler][:module][:authorization] = 'authz_allowall'

# dns:
# chooses the DNS management engine if manage_dns is enabled
# in /etc/cobbler/settings, which is off by default.
# choices:
#    manage_bind    -- default, uses BIND/named
#    manage_dnsmasq -- uses dnsmasq, also must select dnsmasq for dhcp below
# NOTE: more configuration is still required in /etc/cobbler
# for more information:
# https://github.com/cobbler/cobbler/wiki/Dns-management
default[:cobbler][:module][:dhcp] = 'manage_bind'

# dhcp:
# chooses the DHCP management engine if manage_dhcp is enabled
# in /etc/cobbler/settings, which is off by default.
# choices:
#    manage_isc     -- default, uses ISC dhcpd
#    manage_dnsmasq -- uses dnsmasq, also must select dnsmasq for dns above
# NOTE: more configuration is still required in /etc/cobbler
# for more information:
# https://github.com/cobbler/cobbler/wiki/Dhcp-management
default[:cobbler][:module][:dhcp] = 'manage_isc'

# tftpd:
# chooses the TFTP management engine if manage_tftp is enabled
# in /etc/cobbler/settings, which is ON by default.
#
# choices:
#    manage_in_tftpd -- default, uses the system's tftp server
#    manage_tftpd_py -- uses cobbler's tftp server
#
default[:cobbler][:module][:tftpd] = 'manage_in_tftpd'
