{ config, lib, ... }:
let
  inherit (lib) mkOption types;
  # https://github.com/NixOS/nixpkgs/blob/45c9736ed69800a6ff2164fb4538c9e40dad25d6/nixos/modules/config/users-groups.nix#L10
  passwdEntry = type: lib.types.addCheck type isPasswdCompatible // {
    name = "passwdEntry ${type.name}";
    description = "${type.description}, not containing newlines or colons";
  };
in {
  options = {
    admin-name = mkOption {
        type = passwdEntry types.str;
        apply = x: assert (builtins.stringLength x < 32 || abort "Username '${x}' is longer than 31 characters which is not allowed!"); x;
        default = "COGETI";
    };
  };
  config = {
    users.users.${config.admin-name} = {
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
  };
}
