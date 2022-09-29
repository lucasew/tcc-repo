{ pkgs, lib, ... }:
# credits for
# - https://mt-caret.github.io/blog/posts/2020-07-25-ldap-client-with-nixos.html
# - https://www.forumsys.com/2022/05/10/online-ldap-test-server/
{
  users.ldap = {
    enable = true;
    daemon.enable = true;
    bind.policy = "soft";
    bind.distinguishedName = "cn=admin,dc=example,dc=com";
    # users: riemann gauss euler euclid
    bind.passwordFile = builtins.toFile "passwd-file" "password";
    base = "ou=mathematicians,dc=example,dc=com";
    server = "ldap://192.168.100.50";
    # useTLS = true;
    loginPam = true;
    extraConfig = ''
      ldap_version 3
      # pam_password ssha
      pam_password md5
    '';
  };
  # security.pam.services.sshd = {
  #   makeHomeDir = true;
  #   text = lib.mkDefault (
  #     lib.mkBefore ''
  #       auth required pam_listfile.so \
  #         item=group sense=allow onerr=fail file=/etc/allowed_groups
  #     ''
  #   );
  # };
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
