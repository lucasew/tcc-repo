{config, pkgs, lib, flake, ...}:
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
        url = "https://static.wikia.nocookie.net/elderscrolls/images/6/63/Solitude.svg";
        sha256 = "1vymi8ihw9006cxbbd5k16d0ilf5z7kyzgxcpwha0q0wl7262x0q";
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
}
