{...}:
{
  imports = [
    ./hardware-configuration.nix
    ../common/default.nix
  ];
  utfos.machine-group = [ "poc" ];
  boot.loader.grub.devices = [ "/dev/sda" ];
}
