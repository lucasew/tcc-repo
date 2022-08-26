{ config, lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (config.utfos) admin-name;
in {
  users.users.${admin-name} = {
    uid = 1000;
    initialHashedPassword = "$6$eoMv4D9oaYUaJxfl$GNkj3IiBT6cumLcP0tn/uyIIgu/YhDz35MtKloJPFtiQobJh3Qo5lV9ckwgiT9fMaChkMVLtJGOHojG8mO33p/";
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
