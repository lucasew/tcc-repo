{ lib, ... }: {
  services.k3s = {
    enable = true;
    role = lib.mkDefault "agent";
    serverAddr = "https://192.168.0.101:6443";
    tokenFile = "/var/lib/rancher/k3s/agent-token";
  };
}
