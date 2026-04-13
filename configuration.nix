{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    modules/boot.nix
    modules/greetd.nix
    modules/security.nix
    modules/services.nix
    modules/battery.nix
    modules/thinkfan.nix
    modules/bluetooth.nix
    modules/audio.nix
    modules/nvidia.nix
    modules/nix-ld.nix
    modules/wine.nix
    modules/thunar.nix
    modules/gaming.nix
    modules/docker.nix
    modules/prismlauncher.nix
    modules/virtual.nix
    modules/irc.nix
    modules/tor.nix
  ];

  # Allow unfree packages (e.g., NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  # Shell
  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  networking.hostName = "ThinkpadT480"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy =ça  "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  security.sudo.extraConfig = ''
    Defaults insults
  '';

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "oss";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.sacha = {
    isNormalUser = true;
    description = "sacha";
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     networkmanager
     networkmanagerapplet
     pipewire
     wireplumber
     polkit
     blueman
     thinkfan
     lm_sensors
     btop-cuda
     python314Packages.nvidia-ml-py
     throttled
     stdenv.cc.cc.lib
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  programs.hyprland.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
