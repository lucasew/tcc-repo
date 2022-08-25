{...}: {
  imports = [
    ../bootstrap
  ];
  utfos.machine-group = ["common"];
  users.mutableUsers = true; # LDAP vai exigir isso provavelmente
}
