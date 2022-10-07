{ pkgs, config, ... }: {
  systemd.services.app-preload = {
    description = "Preloads explicitly installed apps on RAM";
    path = with pkgs; [
      util-linux # ionice
      vmtouch    # file prefetching
    ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    script = let
      pathsToPrefetch = with pkgs; [
        "/etc/flake"
        dbus
        networkmanager
        avahi
        ananicy
        cpufrequtils
        k3s
        udisks2
        firefox
        chromium
      ];
    in builtins.concatStringsSep "\n" (map (path: ''
      echo "Preloading path: ${path}"
      nice -n 19 ionice -c 2 -n 7 vmtouch -tf "${path}"
    '') pathsToPrefetch);
  };
  systemd.services.nix-store-preload = {
    description = "Preloads file structure of the closure of the current system";
    path = with pkgs; [
      util-linux # ionice
      findutils  # list folders
      nix        # list dependencies
    ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    script = ''
      nix-store --query --references /run/current-system | grep -v source | while read line; do
        echo "Preloading file tree: $line"
        nice -n 19 ionice -c2 -n7 find "$line" > /dev/null
      done
    '';
  };
}
