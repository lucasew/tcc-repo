{config, pkgs, lib, ...}: {
  config = {
    systemd.user.services.apply-keyboard = {
      path = with pkgs; [ glib ];
      wantedBy = [ "graphical-session.target" ];
      script = ''
        gsettings set org.gnome.desktop.input-sources sources "[('xkb','br')]"
      '';
    };
  };
}
