{ pkgs, lib, ... }:
# credits for
# - https://mt-caret.github.io/blog/posts/2020-07-25-ldap-client-with-nixos.html
# - https://www.forumsys.com/2022/05/10/online-ldap-test-server/
# - https://docs.oracle.com/cd/E37670_01/E41138/html/ol_sssd_ldap.html
{
  # services.sssd.enable = true;
  # services.sssd.config = ''
  #   [sssd]
  #   config_file_version = 2
  #   domains = default
  #   services = nss, pam

  #   [domain/default]
  #   id_provider = ldap
  #   access_provider = ldap
  #   auth_provider = ldap
  #   ldap_uri = ldap://192.168.100.50
  #   ldap_id_use_start_tls = false
  #   ldap_search_base = dc=example,dc=com

  #   [nss]
  #   reconnection_retries = 3
  #   entry_cache_timeout = 5

  #   [pam]
  #   reconnection_retries = 3
  #   offline_credentials_expiration = 2
  #   offline_failed_login_attempts = 3
  #   offline_failed_login_delay = 5

  # '';
  users.ldap = {
    enable = true;
    daemon.enable = true;
    base = "dc=example,dc=com";
    bind.policy = "soft";
    bind.distinguishedName = "cn=admin,dc=example,dc=com";
    bind.passwordFile = builtins.toFile "passwd-file" "password";
    server = "ldap://192.168.100.50";
    # useTLS = true;
    loginPam = true;
    extraConfig = ''
      ldap_version 3
      pam_password md5
    '';
  };
  security.pam.services.sshd = {
    makeHomeDir = true;
    # text = lib.mkDefault (
    #   lib.mkBefore ''
    #     auth required pam_listfile.so \
    #       item=group sense=allow onerr=fail file=/etc/allowed_groups
    #   ''
    # );
  };
  security.pam.services.gdm-launch-environment.makeHomeDir = true;
  security.pam.services.login.makeHomeDir = true;
  security.pam.services.systemd-user.makeHomeDir = true;
  systemd.services.nslcd = {
    after = [ "Network-Manager.service" ];
  };
  systemd.tmpfiles.rules = [
    "L /bin/bash - - - - /run/current-system/sw/bin/bash"
  ];
  # environment.etc.allowed_groups = {
  #   text = "mathematicians";
  #   mode = "0444";
  # };
}
