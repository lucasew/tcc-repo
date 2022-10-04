{ ... }: {
  imports = [
    ../common
  ];

  boot.loader.grub.devices = [ "/dev/sda" "/dev/nvme0n1" ];
  fileSystems."/" = {
    label = "nixos";
    fsType = "ext4";
  };
}
