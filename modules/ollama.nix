{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    
    package = pkgs.ollama-vulkan;

    # loadModels = [ "qwen2.5-coder:7b" ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime # Support OpenCL/Vulkan
    ];
  };

  # Optionnel : Ajout de l'interface CLI dans le PATH utilisateur
  environment.systemPackages = [ pkgs.ollama-vulkan ];
}
