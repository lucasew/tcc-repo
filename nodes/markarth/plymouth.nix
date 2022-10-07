{config, pkgs, lib, ...}:
let
  v86d = config.boot.kernelPackages.v86d.overrideAttrs (old: {
    hardeningDisable = [ "all" ];
  });
in{
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # TODO: trocar a engrenagem girando por algo menos tosco
    logo = pkgs.stdenv.mkDerivation {
      name = "out.png";
      dontUnpack = true;
      src = pkgs.fetchurl {
        url = "https://static.wikia.nocookie.net/elderscrolls/images/9/9b/MarkarthSide.svg";
        sha256 = "0y7vvjwjxcbxw2b35pvkcxgwxkhiadaxqp462giay8dvgg5r5cj5";
      };
      nativeBuildInputs = with pkgs; [
        inkscape
      ];
      buildPhase = ''
        inkscape --export-type="png" $src -o wallpaper.png -w 150 -h 210 -o wallpaper.png
      '';
      installPhase = ''
        install -Dm0644 wallpaper.png $out
      '';
    };
  };
  boot.initrd.kernelModules = [ "uvesafb" ];
  boot.initrd.extraFiles."/usr/v86d".source = v86d;
  boot.kernelParams = [
    "video=uvesafb:mode:${config.boot.loader.grub.gfxmodeBios}-32,mtrr:3,ywrap"
    ''uvesafb.v86d="${v86d}/bin/v86d"''
  ];
}
