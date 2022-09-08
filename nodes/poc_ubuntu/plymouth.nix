{config, pkgs, lib, ...}: {
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # TODO: trocar a engrenagem girando por algo menos tosco
    logo = pkgs.stdenv.mkDerivation {
      name = "out.png";
      dontUnpack = true;
      src = pkgs.fetchurl {
        url = "http://www.utfpr.edu.br/icones/cabecalho/logo-utfpr/@@images/efcf9caf-6d29-4c24-8266-0b7366ea3a40.png";
        sha256 = "1gk744rkiqqla7k7qqdjicfaccryyxqwim8iv3di21k2d0glazns";
      };
      nativeBuildInputs = with pkgs; [
        imagemagick
      ];
      installPhase = ''
        convert -resize 50% $src $out
      '';
    };
  };
  boot.initrd.kernelModules = [ "uvesafb" ];
  boot.initrd.extraFiles."/bin/v86d".source = pkgs.runCommand "v86d" {} ''
    cp "${config.boot.kernelPackages.v86d}/bin/v86d" $out
  '';
  boot.kernelParams = [
    "video=uvesafb:1920x1080-32,mtrr:3,ywrap"
    ''uvesafb.v86d="/bin/v86d"''
  ];
}
