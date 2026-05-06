{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Disk encryption
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/9b9f1d4d-d489-46cf-b827-b8dd34419a6b";

    supportedFilesystems = [ "ntfs" ];
  };
}
