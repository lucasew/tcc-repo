{pkgs, ...}: {
  imports = [
    ../bootstrap
    ./ldap.nix
    ./dns.nix
    ./tuning.nix
    ./smart.nix
    ./memtest86.nix
  ];
  utfos.machine-group = ["common"];
  users.mutableUsers = true; # LDAP vai exigir isso provavelmente
  # gui
  environment.systemPackages = with pkgs; [
    chromium
    curl
    direnv
    firefox
    htop
    lm_sensors
    neofetch
    pciutils
    rlwrap
    spotify
    unrar
    usbutils
    wget
  ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
