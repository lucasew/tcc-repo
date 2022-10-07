{ ... }: {
  services.k3s = {
    enable = true;
    role = "server";
    serverAddr = "https://192.168.0.101:6443";
  };
}
