{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    nano
    git
    tmux
    xclip
    neofetch
  ];
  environment.variables.EDITOR = lib.mkDefault "nano";
}
