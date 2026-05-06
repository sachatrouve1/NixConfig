{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    supertuxkart
    ryubing
    heroic
    # lutris
  ];
}
