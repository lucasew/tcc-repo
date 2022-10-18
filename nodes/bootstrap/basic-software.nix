{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    tmux
    xclip
    neofetch
    curl
    lm_sensors
    pciutils
    rlwrap
    usbutils
    wget
  ];
  environment.variables.EDITOR = lib.mkDefault "nano";
}
