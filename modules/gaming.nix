{
  config,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
  };
}
