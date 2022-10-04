{pkgs, modulesPath, self, lib, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.hostName = "install";

  environment.etc."_nixos-bootstrap-generation".source = self.outputs.nixosConfigurations.demo.config.system.build.toplevel;
}
