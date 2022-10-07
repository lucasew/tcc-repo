{ lib, config, ... }: {
  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent";
    serverAddr = lib.mkIf (config.services.k3s.role == "agent") "https://192.168.0.101:6443";
    tokenFile = lib.mkIf (config.services.k3s.role == "agent") "/var/lib/rancher/k3s/agent-token";
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
