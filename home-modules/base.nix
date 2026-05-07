{ config, pkgs, ... }:
{
  imports = [
    features/fish.nix
    features/git.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop-cuda
    htop
    ncdu
    wget
    bat
    fastfetch
    brightnessctl
    tree
    vim
    gcc
  ];

}
