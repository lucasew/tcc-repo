{ pkgs, lib, config, ... }: {
  imports = [
    "${builtins.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/nixos/modules/system/boot/uvesafb.nix";
      sha256 = "1r6gz7f8s3yanziwasb574gvlajwfqlbykaanilkr3gx08k127c1";
    }}"
  ];
  config = lib.mkIf config.boot.plymouth.enable {
    boot.uvesafb.enable = true;
  };
}
