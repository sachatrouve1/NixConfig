{ config, pkgs, userName, hostName, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia_mx150.nix
    ../../modules/profiles/laptop.nix
    ../../modules/profiles/gaming.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = hostName; # Define your hostname.

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" "kvm" "dialout" "uucp" ];
    packages = with pkgs; [];
  };

  services = {
    throttled.enable = true;
    fwupd.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
