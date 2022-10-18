{pkgs, ...}: {
  imports = [
    ../bootstrap
    ./ldap.nix
    ./dns.nix
    ./tuning.nix
    ./smart.nix
    ./memtest86.nix
    # ./preload.nix
  ];
  utfos.machine-group = ["common"];
  users.mutableUsers = true; # LDAP vai exigir isso provavelmente
  # gui
  environment.systemPackages = with pkgs; [
    direnv
    htop
    neofetch
    unrar
  ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
