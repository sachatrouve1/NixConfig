{ config, pkgs, lib, ... }:

let
  pkgs-9-4 = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/346dd96ad74dc4457a9db9de4f4f57dab2e5731d.tar.gz";
    sha256 = "1f29niwab1n3xmwp5zss0b03wzyzr1nslzx2d3aiz7pvyxrimyzd";
  }) {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = [
    pkgs-9-4.prismlauncher
  ];
}
