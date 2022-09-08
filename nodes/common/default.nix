{pkgs, ...}: {
  imports = [
    ../bootstrap
  ];
  utfos.machine-group = ["common"];
  users.mutableUsers = true; # LDAP vai exigir isso provavelmente
  # gui
  environment.systemPackages = with pkgs; [
    htop
    chromium
    firefox
    spotify
  ];
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
