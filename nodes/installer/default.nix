{pkgs, modulesPath, self, lib, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../bootstrap
  ];

  networking.hostName = "install";

  environment.etc."_nixos-bootstrap-generation".source = (self.outputs.nixosConfigurations.demo.extendModules {
    modules = [
      ({...}: {
        boot.loader.grub.devices = [ "/dev/sda" "/dev/nvme0n1" ];
        fileSystems."/" = {
          label = "nixos";
          fsType = "ext4";
        };
      })
    ];
  }).config.system.build.toplevel;
  environment.etc."code".source = ../../.;

  # defaults set up by the installer module that we don't want
  networking.wireless.enable = false;

  system.stateVersion = lib.mkForce "22.05";
}
