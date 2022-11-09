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
    distrobox
    fd
    firefox
    graphviz
    nbr.appimage-wrap
    nbr.argouml
    nbr.digital-simulator
    nbr.wine-apps._7zip
    nbr.wine-apps.hxd
    nbr.wine-apps.neander
    nbr.wine-apps.sosim
    nbr.wine-apps.taha-tora
    plantuml
    ripgrep
    spotify
    vscode
    xorg.xhost
  ];
}
