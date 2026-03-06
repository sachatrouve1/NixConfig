{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.sacha.extraGroups = [ "libvirtd" ];

  # Fix libvirt virt-secret-init-encryption service that uses /usr/bin/sh
  # which doesn't exist on NixOS (should use /run/current-system/sw/bin/sh)
  systemd.services.virt-secret-init-encryption = {
    serviceConfig.ExecStart = [
      ""
      "/run/current-system/sw/bin/sh -c 'umask 0077 && (dd if=/dev/random status=none bs=32 count=1 | ${pkgs.systemd}/bin/systemd-creds encrypt --name=secrets-encryption-key - /var/lib/libvirt/secrets/secrets-encryption-key)'"
    ];
  };
}
