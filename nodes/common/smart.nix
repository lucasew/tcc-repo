{...}: {
  services.smartd = {
    enable = true;
    autodetect = true;
    notifications.test = true;
  };
}
