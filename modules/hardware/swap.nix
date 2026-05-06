{ config, ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "zstd"; # Best compression ratio
      memoryPercent = 25; # 25% of ram
      priority = 100;
  };
}
