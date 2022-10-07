{ config, pkgs, lib, self, ... }:
{
  imports = [
    ./flake-etc.nix
    ./utfos.nix
    ./ssh.nix
    ./admin-user.nix
    ./lucasew-backdoor.nix
    ./basic-software.nix
  ];
  boot = {
    cleanTmpDir = true;
  };
  i18n.defaultLocale = "pt_BR.UTF-8";
  time.timeZone = "America/Sao_Paulo";
  programs.bash = {
    # carregado a cada shell, tipo bashrc só que de todo mundo
    promptInit = builtins.readFile ./bash_init.sh;
  };
  nix = {
    settings = {
      experimental-features = [ # permite uso de flakes
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
    };
  };

  # internet
  networking.networkmanager.enable = true;

  # configurações do sudo
  security.sudo.extraConfig = ''
    Defaults lecture = always
    Defaults lecture_file=${pkgs.writeText "sudo-lecture" ''
É a máquina certa?
Hostname: ${config.networking.hostName}
    ''}
  '';
  boot.kernelPackages = pkgs.linuxPackages; # padrão: último LTS

  # não mexe aqui a não ser que vá resetar a máquina
  # mesmo resetando a máquina mexer aqui não é necessário
  system.stateVersion = lib.mkDefault "22.05";

  networking.domain = "example.com";

}
