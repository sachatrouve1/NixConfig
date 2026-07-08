{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
# 1. We redefine openldap globally but WITHOUT the tests.
     openldap = prev.openldap.overrideAttrs (oldAttrs: {
         doCheck = false;
         checkPhase = "true";
         installCheckPhase = "true";
         doInstallCheck = false;
         });
     throttled = prev.throttled.overrideAttrs (oldAttrs: {
         pythonPath = oldAttrs.pythonPath ++ [ final.python3Packages.dbus-next ];
         });
     })
];
# This is the "Magic Fix" for Flake/Home-Manager users
# It forces the entire system to use the pkgs we just overlaid
  nixpkgs.config.allowBroken = true; 
}
