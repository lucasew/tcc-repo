{pkgs, ...}:
{
  imports = [
    ./hardware-configuration.nix
    ../common/default.nix
  ];
  utfos.machine-group = [ "poc" ];
  boot.loader.grub.devices = [ "/dev/sda" ];

  # gui
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = true;
        gnome.enable = true;
      };
      displayManager.gdm.enable = true;
    };
  };
  environment.systemPackages = with pkgs.gnomeExtensions; [
    night-theme-switcher
    sound-output-device-chooser
    gsconnect
    transparent-shell
  ];
}
