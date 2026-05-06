{ config, pkgs, userName, ... }:
{
  imports = [
    ../../../home-modules/base.nix
  ];

  home.stateVersion = "25.11";

  home.username = userName;
  home.homeDirectory = "/home/${userName}";
}
