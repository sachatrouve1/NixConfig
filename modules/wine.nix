{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    # Standard Wine installation supporting both 32-bit and 64-bit applications
    wineWow64Packages.stable

    # Winetricks for installing common Windows components
    winetricks

    # Bottles for GUI management of Wine prefixes (optional - remove if not needed)
    (pkgs.bottles.override{ removeWarningPopup = true; })
  ];
}
