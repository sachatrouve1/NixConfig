{ config, pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      vulkan-loader
      glfw
      libxkbcommon
      wayland
      icu
      libx11
    ];
  };
}
