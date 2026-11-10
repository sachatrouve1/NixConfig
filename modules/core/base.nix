{ pkgs, ... }:
{
  imports = [
    ../services/overlays.nix
  ];

  services = {
    dbus.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  security.sudo.extraConfig = ''
    Defaults insults
  '';

  nix.settings.auto-optimise-store = true;

  networking.networkmanager.enable = true;

  # Allow unfree packages (e.g., NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.problems.handlers = {
    "gtk+".broken = "warn";
  };

  environment.systemPackages = with pkgs; [
    btop-cuda
    lm_sensors
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
