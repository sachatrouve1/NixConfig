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
      pywal16 = prev.pywal16.overrideAttrs (oldAttrs: {
        makeWrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          (final.lib.makeBinPath ([ final.imagemagick ] ++ final.lib.optional (oldAttrs.withColorz or false) final.colorz))
        ];
      });
      pywal = final.pywal16;
    })
  ];
# This is the "Magic Fix" for Flake/Home-Manager users
# It forces the entire system to use the pkgs we just overlaid
  nixpkgs.config.allowBroken = true; 
}
