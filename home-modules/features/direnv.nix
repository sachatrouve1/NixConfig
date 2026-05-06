{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Version optimisée pour Nix (cache les shell)
    enableFishIntegration = true; # Ou enableZshIntegration
  };
}
