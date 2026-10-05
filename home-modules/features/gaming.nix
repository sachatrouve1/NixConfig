{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (nvidiaOffload supertuxkart)
    (nvidiaOffload ryubing)
    (nvidiaOffload heroic)
    (nvidiaOffload lutris)
  ];

  xdg.desktopEntries.steam = {
    name = "Steam";
    comment = "Application for managing and playing games on Steam";
    exec = "env -u DRI_PRIME steam %U";
    icon = "steam";
    terminal = false;
    type = "Application";
    categories = [ "Network" "FileTransfer" "Game" ];
    mimeType = [ "x-scheme-handler/steam" "x-scheme-handler/steamlink" ];
    settings = {
      PrefersNonDefaultGPU = "false";
      X-KDE-RunOnDiscreteGpu = "false";
    };
  };
}
