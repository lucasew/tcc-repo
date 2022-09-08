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
    pciutils
    usbutils
  ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
