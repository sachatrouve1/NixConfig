{ userName, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    # Nvidia graphics
    graphics = {
      enable = true;
    };

    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      open = false;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    # Luminosity for external display:
    i2c.enable = true;
  };

  users.users.${userName}.extraGroups = [ "i2c" ];
}
