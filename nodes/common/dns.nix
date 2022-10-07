{config, ...}: {
  services.dnsmasq = {
    enable = true;
    servers = [ "8.8.8.8" "8.8.4.4" ];
    extraConfig = ''
domain-needed
bogus-priv
hostsdir=/etc/extraHosts
address=/server.${config.networking.domain}/192.168.0.100
address=/controlplane.${config.networking.domain}/192.168.0.101
address=/solitude.${config.networking.domain}/192.168.0.101
address=/markarth.${config.networking.domain}/192.168.0.102
address=/morthal.${config.networking.domain}/192.168.0.103
    '';
  };
}
