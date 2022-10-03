{config, pkgs, lib, ...}: {
  options.wallpaper = lib.mkOption {
    description = "Wallpaper para ser aplicado no sistema depois do login";
    type = lib.types.path;
    default = pkgs.fetchurl {
      url = "https://images.alphacoders.com/203/203543.jpg";
      sha256 = "1hm4nz0rgy2zbn2q6vq9c6jfnnaqq61fkny6syvna5i65ca468hm";
    };
  };
  config = {
    systemd.user.services.apply-wallpaper = {
      path = with pkgs; [ glib ];
      wantedBy = [ "graphical-session.target" ];
      script = ''
        gsettings set org.gnome.desktop.background picture-uri 'file://${config.wallpaper}'
        gsettings set org.gnome.desktop.background picture-uri-dark 'file://${config.wallpaper}'
      '';
    };
  };
}
