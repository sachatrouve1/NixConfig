{ pkgs, ... }:
{
  services = {
    # service to show battery information
    upower.enable = true;

    # to get the permissions to change luminosity
    udev.packages = [ pkgs.acpilight ];

    # NetworkManager powersave
    # networking.networkmanager.wifi.powersave = true;

    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
