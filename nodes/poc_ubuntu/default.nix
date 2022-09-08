{pkgs, self, ...}:
let
  inherit (self.inputs) nixos-hardware;
in {
  imports = [
    nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
    nixos-hardware.nixosModules.common-gpu-intel
    nixos-hardware.nixosModules.common-pc-hdd
    nixos-hardware.nixosModules.common-gpu-amd
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
