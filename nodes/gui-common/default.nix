{ pkgs, flake, ... }:
{
  imports = [
    ../common/default.nix
    ./wallpaper.nix
    ./containers.nix
    ./gnome.nix
    ./motd.nix
    # ./kubernetes.nix
    ./virtualbox.nix
    ./plymouth.nix
  ];
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    spotify
    nbr.appimage-wrap
    distrobox
  ];
}
