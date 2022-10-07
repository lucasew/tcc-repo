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
    ./plymouth.nix
    ../gui-common/default.nix
  ];
  utfos.machine-group = [ "poc" ];
  boot.loader.grub.devices = [ "/dev/sda" ];
  nixpkgs.config.rocmTargets = [ "gfx000" "gfx803" ]; # rocm_agent_enumerator
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];
  networking.hostName = "markarth";
}
