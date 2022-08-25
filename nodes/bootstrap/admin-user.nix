{ config, lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (config.utfos) admin-name;
in {
  users.users.${admin-name} = {
    uid = 1000;
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [
      # é isso mesmo, dá pra atualizar as chaves aceitas por um usuário de forma declarativa
      ../../authorized_keys
    ];
    extraGroups = [
      "wheel"
    ];
  };
}
