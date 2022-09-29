{ lib, ... }:
let
  inherit (lib) types mkOption;
in {
  options = {
    utfos = {
      machine-group = mkOption {
        type = types.listOf types.str;
        description = "De quais grupos tal máquina participa";
        default = [];
      };
      admin-name = mkOption {
        # https://github.com/NixOS/nixpkgs/blob/45c9736ed69800a6ff2164fb4538c9e40dad25d6/nixos/modules/config/users-groups.nix#L10
        type = let
            isPasswdCompatible = str: !(lib.hasInfix ":" str || lib.hasInfix "\n" str);
            newType = lib.types.addCheck types.str isPasswdCompatible;
          in newType // {
            name = "passwdEntry ${newType.name}";
            description = "${newType.description}, not containing newlines or colons";
          };
        apply = x: assert (builtins.stringLength x < 32 || abort "Username '${x}' is longer than 31 characters which is not allowed!"); x;
        default = "admin";
      };
    };
  };
}
