# These settings are documented in more detail at
# https://gitlab.com/gitlab-org/gitlab-ce/blob/a0a826ebdcb783c660dd40d8cb217db28a9d4998/config/gitlab.yml.example#L136
# Be careful not to break the identation in the ldap_servers block. It is in
# yaml format and the spaces must be retained. Using tabs will not work.

gitlab_rails['ldap_enabled'] = true
gitlab_rails['ldap_servers'] = YAML.load <<-EOS # remember to close this block with 'EOS' below
main: # 'main' is the GitLab 'provider ID' of this LDAP server
  ## label
  #
  # A human-friendly name for your LDAP server. It is OK to change the label later,
  # for instance if you find out it is too large to fit on the web page.
  #
  # Example: 'Paris' or 'Acme, Ltd.'
  label: 'Ldap'

  host: 'openldap'
  port: 389
  uid: 'uid'
  encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
  
  # Uncomment the next line with your own domain
  # bind_dn: 'CN=admin,DC=organisation,DC=com'
  # password: '${YOUR_PASSWORD}'

  # This setting specifies if LDAP server is Active Directory LDAP server.
  # For non AD servers it skips the AD specific queries.
  # If your LDAP server is not AD, set this to false.
  active_directory: false

  # If allow_username_or_email_login is enabled, GitLab will ignore everything
  # after the first '@' in the LDAP username submitted by the user on login.
  #
  # Example:
  # - the user enters 'jane.doe@example.com' and 'p@ssw0rd' as LDAP credentials;
  # - GitLab queries the LDAP server with 'jane.doe' and 'p@ssw0rd'.
  #
  # If you are using "uid: 'userPrincipalName'" on ActiveDirectory you need to
  # disable this setting, because the userPrincipalName contains an '@'.
  allow_username_or_email_login: false

  # If lowercase_usernames is enabled, GitLab will lower case the username.
  lowercase_usernames: false

  # Base where we can search for users
  #
  #   Ex. ou=People,dc=gitlab,dc=example
  #
  base: 'cn=users,dc=YOUR_ORGANISATION,dc=com'

  # Filter LDAP users
  #
  #   Format: RFC 4515 http://tools.ietf.org/search/rfc4515
  #   Ex. (employeeType=developer)
  #
  #   Note: GitLab does not support omniauth-ldap's custom filter syntax.
  #
  user_filter: ''

  group_base: 'cn=groups'
  admin_group: 'cn=gitlab_admins'
EOS