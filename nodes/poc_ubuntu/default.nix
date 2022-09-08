{pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ./gnome.nix
    ./plymouth.nix
    ./wallpaper.nix
    ./motd.nix
    ./keyboard.nix
    ../common/default.nix
  ];
  utfos.machine-group = [ "poc" ];
  boot.loader.grub.devices = [ "/dev/sda" ];

}
