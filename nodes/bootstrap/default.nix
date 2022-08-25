{ config, pkgs, lib, self, ... }:
{
  imports = [
    ./flake-etc.nix
    ./utfos.nix
    ./ssh.nix
    ./admin-user.nix
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
    };
  };
  # configurações do sudo
  security.sudo.extraConfig = ''
    Defaults lecture = always
    Defaults lecture_file=${pkgs.writeText "sudo-lecture" ''
É a máquina certa?
Hostname: ${config.network.hostname}
    ''}
  '';
  boot.kernelPackages = pkgs.linuxPackages; # padrão: último LTS

  # não mexe aqui a não ser que vá resetar a máquina
  # mesmo resetando a máquina mexer aqui não é necessário
  system.stateVersion = "22.05";

}
