{ config, ... }:
{
  imports = [
    ../hardware/audio.nix
    ../hardware/battery.nix
    ../hardware/bluetooth.nix
    ../hardware/boot.nix
    ../hardware/thinkfan.nix
    ../hardware/swap.nix
    ../core/base.nix
    ../core/locale.nix
    ../core/shell.nix
    ../core/firewall.nix
    ../core/hardening.nix
    ../services/greetd.nix
    ../services/docker.nix
    ../services/ollama.nix
    ../services/thunar.nix
    ../services/nix-ld.nix
    ../services/virtual.nix
    ../services/wine.nix
  ];

  programs.hyprland.enable = true;
}
