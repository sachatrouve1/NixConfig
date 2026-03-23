{ config, pkgs, ... } :
{
  services = {
    playerctld.enable = true;
    dbus.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    throttled.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
  };

  # services.smartcardDev = {
  #   enable = true;
  #   enableJavaCard = true;
  #   user = "sacha";
  # };
}
