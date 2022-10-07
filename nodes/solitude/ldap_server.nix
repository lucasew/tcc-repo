{ ... }: {
  services.openldap = {
    enable = true;
    settings.includes = [ ../../docker/ldap/forumsys.ldif ];
  };
}
