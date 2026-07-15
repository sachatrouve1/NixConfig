{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      throttled = prev.throttled.overrideAttrs (oldAttrs: {
        pythonPath = oldAttrs.pythonPath ++ [ final.python3Packages.dbus-next ];
      });
      haskellPackages = prev.haskellPackages.override {
        overrides = hfinal: hprev: {
          pdftotext = prev.haskell.lib.dontCheck hprev.pdftotext;
        };
      };
    })
  ];
# This is the "Magic Fix" for Flake/Home-Manager users
# It forces the entire system to use the pkgs we just overlaid
  nixpkgs.config.allowBroken = true; 
}
