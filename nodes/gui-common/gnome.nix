{pkgs, ...}: {
  services = {
    xserver = {
      videoDrivers = [ "modesetting" ];
      enable = true;
      desktopManager = {
        xterm.enable = false;
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
