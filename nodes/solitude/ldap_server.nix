{ ... }: {
  services.openldap = {
    enable = true;
    declarativeContents."dc=example,dc=com" = builtins.readFile ../../docker/ldap/forumsys.ldif;
  };
}
