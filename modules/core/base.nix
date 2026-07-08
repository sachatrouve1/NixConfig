{ config, pkgs, ...}:
{
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.openssh.enable = true;

  security.sudo.extraConfig = ''
    Defaults insults
    '';

  nix.settings.auto-optimise-store = true;

  networking.networkmanager.enable = true;

  # Allow unfree packages (e.g., NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop-cuda
    lm_sensors
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
