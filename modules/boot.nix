{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Disk encryption
    # initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/UUID-OF-SDA2";

    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  displayManager.autologin = {
    enable = true;
    user = "sacha";
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  # Autostart Hyprland
  programs.bash.interactiveShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
