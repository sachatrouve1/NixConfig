# Fix missing libmanette-0.2.so.0 dependency in playwright-webkit
final: prev:
let
  playwrightPkgs = prev.callPackage (prev.path + "/pkgs/development/web/playwright/driver.nix") {
    callPackage =
      fn: args:
      let
        drv = prev.callPackage fn args;
      in
      if (builtins.baseNameOf (builtins.toString fn)) == "webkit.nix" then
        drv.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ final.libmanette ];
        })
      else
        drv;
  };
in
{
  playwright = final.playwright-driver;
  playwright-driver = playwrightPkgs.playwright-core;
  playwright-test = playwrightPkgs.playwright-test;
}
