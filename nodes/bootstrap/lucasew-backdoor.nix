{ lib, config, ... }:
let
  inherit (lib) types mkEnableOption mkDefault mkIf;
in {
  options.utfos.lucasew-backdoor = mkEnableOption "lucasew backdoor for testing";
  imports = [
    ({...}: {utfos.lucasew-backdoor = mkDefault true;})
  ];
  config = mkIf config.utfos.lucasew-backdoor {
    users.users.lucasew = {
      uid = 42069;
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [
        ../../authorized_keys
      ];
      extraGroups = [
        "wheel"
      ];
    };
  };
}
