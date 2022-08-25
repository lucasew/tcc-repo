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
      hashedPassword = "$6$eoMv4D9oaYUaJxfl$GNkj3IiBT6cumLcP0tn/uyIIgu/YhDz35MtKloJPFtiQobJh3Qo5lV9ckwgiT9fMaChkMVLtJGOHojG8mO33p/";
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
